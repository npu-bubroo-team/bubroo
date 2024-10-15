import 'package:flutter/material.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/models/job_post.dart';
import 'package:flutter_tiktok/services/job_service.dart';
import 'package:flutter_tiktok/pages/followPage.dart';
class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool isVideoPost = true; // 用于切换视频发布和招聘信息发布
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _locationController = TextEditingController();
  final _salaryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
final _videoUrlController = TextEditingController();
  
  String _imageUrl = ''; // 用于存储图片URL
  String _videoUrl = ''; // 用于存储视频URL

  @override
  void initState() {
    super.initState();
    _imageUrl = 'https://images.pexels.com/photos/27163466/pexels-photo-27163466.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load'; // 设置默认图片URL
    _videoUrl = 'https://videos.pexels.com/video-files/28679251/12451274_1920_1080_24fps.mp4'; // 设置默认视频URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布新内容'),
        actions: [
          TextButton(
            onPressed: () {
              // 处理发布逻辑
              if (isVideoPost) {
                // 发布视频到媒体栏
                _postVideo();
              } else {
                // 发布招聘信息
                _postJob();
              }
            },
            child: Text('发布', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 切换发布类型
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('发布视频'),
                  selected: isVideoPost,
                  onSelected: (selected) {
                    setState(() {
                      isVideoPost = selected;
                    });
                  },
                ),
                SizedBox(width: 20),
                ChoiceChip(
                  label: Text('发布招聘'),
                  selected: !isVideoPost,
                  onSelected: (selected) {
                    setState(() {
                      isVideoPost = !selected;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            // 根据选择显示不同的内容
            Expanded(
              child: isVideoPost ? _buildVideoPostUI() : _buildJobPostUI(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPostUI() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // 选择视频逻辑
          },
          child: Text('选择视频'),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: '添加视频描述...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildJobPostUI() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: '职位名称',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _companyController,
          decoration: InputDecoration(
            labelText: '公司名称',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _locationController,
          decoration: InputDecoration(
            labelText: '工作地点',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _salaryController,
          decoration: InputDecoration(
            labelText: '薪资范围',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            labelText: '职位描述',
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
        ),
        SizedBox(height: 16),
        TextField(
          controller: _imageUrlController,
          decoration: InputDecoration(
            labelText: '图片 URL',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _imageUrl = value;
            });
          },
        ),
        SizedBox(height: 16),
        TextField(
          controller: _videoUrlController,
          decoration: InputDecoration(
            labelText: '视频 URL',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _videoUrl = value;
            });
          },
        ),
      ],
    );
  }

  void _postVideo() {
    // 实现视频发布逻辑
    print('发布视频到媒体栏');
    // TODO: 将视频添加到最左侧的媒体栏
    Navigator.pop(context);
  }

  void _navigateToFollowPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FollowPage()),
    );
  }
  void _postJob() async {
    JobPost newJob = JobPost(
      image: _imageUrl,
      company: _companyController.text,
      title: _titleController.text,
      salary: _salaryController.text,
      description: _descriptionController.text,
      videoUrl: _videoUrl,
      location: _locationController.text,
    );

    try {
      await JobService.addJob(newJob);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('招聘信息发布成功！')),
      );
      _navigateToFollowPage();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('发布失败：$error')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _videoUrlController.dispose();
    super.dispose();
  }
}
