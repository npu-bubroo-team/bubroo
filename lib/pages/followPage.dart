import 'package:flutter/material.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'dart:math' as math;
import 'package:flutter_tiktok/pages/messagePage.dart'; 
import 'package:flutter_tiktok/models/message_store.dart'; 
import 'package:video_player/video_player.dart';
import 'package:flutter_tiktok/models/job_post.dart';
import 'package:flutter_tiktok/services/job_service.dart';
import 'package:flutter_tiktok/pages/searchPage.dart';

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  List<JobPost> jobs = [];
  List<JobPost> favorites = [];
  int currentIndex = 0;
  double _dragPosition = 0;
  double _dragPositionY = 0;
  bool _isDragging = false;
  bool _isExpanded = false;
  bool isLoading = true;

  late VideoPlayerController _videoPlayerController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<JobPost> loadedJobs = await JobService.getJobs();
      setState(() {
        jobs = loadedJobs;
        isLoading = false;
        if (jobs.isNotEmpty) {
          _initializeVideo(jobs[currentIndex].videoUrl);
        }
      });
    } catch (e) {
      print('Error loading jobs: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _initializeVideo(String videoUrl) {
    _videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom + 50;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        leading: IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: _showSearchPage,
        ),
        title: Text('招聘信息', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: _showFavorites,
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : jobs.isEmpty
              ? Center(child: Text('暂无招聘信息', style: TextStyle(color: Colors.white)))
              : Padding(
                  padding: EdgeInsets.only(bottom: bottomPadding),
                  child: GestureDetector(
                    onHorizontalDragStart: _onDragStart,
                    onHorizontalDragUpdate: _onDragUpdate,
                    onHorizontalDragEnd: _onDragEnd,
                    onVerticalDragStart: _onVerticalDragStart,
                    onVerticalDragUpdate: _onVerticalDragUpdate,
                    onVerticalDragEnd: _onVerticalDragEnd,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        if (currentIndex < jobs.length - 1) _buildCard(currentIndex + 1, 2),
                        if (currentIndex < jobs.length - 1) _buildCard(currentIndex + 1, 1),
                        _buildCard(currentIndex, 0),
                        if (_isExpanded) _buildExpandedInfo(jobs[currentIndex]),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildCard(int jobIndex, int stackIndex) {
    final job = jobs[jobIndex];
    final screenSize = MediaQuery.of(context).size;
    final cardWidth = screenSize.width * 0.95;
    final cardHeight = screenSize.height * 0.75;

    return Positioned(
      left: 20.0 * stackIndex,
      child: Transform.translate(
        offset: stackIndex == 0 ? Offset(_dragPosition, _dragPositionY) : Offset(0, 0),
        child: Transform.scale(
          scale: 1 - (0.05 * stackIndex),
          child: Opacity(
            opacity: 1 - (0.2 * stackIndex),
            child: Container(
              width: cardWidth,
              height: cardHeight,
              child: Stack(
                children: [
                  JobCard(
                    job: job,
                    onTap: () => _showUserDetails(job),
                  ),
                  if (_isDragging && stackIndex == 0)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: _buildActionLabel(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionLabel() {
    if (_dragPosition > 50) {
      return _buildOverlayLabel('喜欢', Colors.green);
    } else if (_dragPosition < -50) {
      return _buildOverlayLabel('不喜欢', Colors.red);
    }
    return SizedBox.shrink();
  }

  Widget _buildExpandedInfo(JobPost job) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 视频播放器（如果有的话）
            if (_isVideoInitialized)
              AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              ),
            
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '职位详情',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildInfoRow(Icons.business, '公司', job.company),
                  _buildInfoRow(Icons.work, '职位', job.title),
                  _buildInfoRow(Icons.attach_money, '薪资', job.salary),
                  _buildInfoRow(Icons.location_on, '地点', job.location),
                  SizedBox(height: 15),
                  Text(
                    '职位描述',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    job.description,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _navigateToMessagePage(job),
                      child: Text('申请职位'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,  // 使用 backgroundColor 替代 primary
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          SizedBox(width: 10),
          Text(
            '$label: ',
            style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlayLabel(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    setState(() => _isDragging = true);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() => _dragPosition += details.delta.dx);
  }

  void _onDragEnd(DragEndDetails details) {
    if (_dragPosition.abs() > 100) {
      if (_dragPosition > 0) {
        _addToFavorites();
      }
      _nextUser();
    }
    setState(() {
      _dragPosition = 0;
      _isDragging = false;
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {
    setState(() => _isDragging = true);
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() => _dragPositionY += details.delta.dy);
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_dragPositionY < -50) {
      setState(() {
        _isExpanded = true;
        if (_isVideoInitialized) {
          _videoPlayerController.play();
        }
      });
    } else if (_dragPositionY > 50 && _isExpanded) {
      setState(() {
        _isExpanded = false;
        if (_isVideoInitialized) {
          _videoPlayerController.pause();
        }
      });
    }
    setState(() {
      _dragPositionY = 0;
      _isDragging = false;
    });
  }

  void _nextUser() {
    setState(() {
      if (currentIndex < jobs.length - 1) {
        currentIndex++;
        _initializeVideo(jobs[currentIndex].videoUrl);
      } else {
        _loadJobs(); // 重新加载工作
      }
      _isExpanded = false;
    });
  }

  void _addToFavorites() {
    if (!favorites.contains(jobs[currentIndex])) {
      setState(() {
        favorites.add(jobs[currentIndex]);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已添加到收藏夹: ${jobs[currentIndex].company}')),
      );
    }
  }

  void _showFavorites() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('收藏夹'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                final JobPost job = favorites[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(job.image),
                  ),
                  title: Text('${job.company}, ${job.title}'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _showUserDetails(job);
                  },
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('关闭'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showUserDetails(JobPost job) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    job.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  job.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  job.company,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Colors.blue),
                    SizedBox(width: 5),
                    Text(job.location, style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  job.salary,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  job.description,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text('申请职位'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _navigateToMessagePage(job);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                    OutlinedButton(
                      child: Text('关闭'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: BorderSide(color: Colors.grey),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToMessagePage(JobPost job) {
    // 创建新的私信对话
    MessageStore.addConversation(job.company, job);
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MessagePage(job: job),
      ),
    );
  }

  void _swipeLeft() {
    setState(() {
      if (currentIndex < jobs.length - 1) {
        currentIndex++;
      }
      _dragPosition = 0;
    });
  }

  void _swipeRight() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
      _dragPosition = 0;
    });
  }

  void _showSearchPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchPage(
          onPop: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final JobPost job;
  final VoidCallback onTap;

  JobCard({required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                job.image,
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.company,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    job.title,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    job.salary,
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}