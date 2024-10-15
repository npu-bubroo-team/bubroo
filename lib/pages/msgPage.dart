import 'package:flutter_tiktok/pages/msgDetailListPage.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/views/tilTokAppBar.dart';
import 'package:flutter_tiktok/views/userMsgRow.dart';
import 'package:flutter/material.dart';
import 'package:tapped/tapped.dart';
import 'package:flutter_tiktok/models/message_store.dart'; // 添加这行
import 'package:flutter_tiktok/pages/messagePage.dart'; // 添加这行
import 'package:flutter_tiktok/models/job_post.dart';
import 'package:carousel_slider/carousel_slider.dart'; //轮播图插件
class MsgPage extends StatefulWidget {
  @override
  _MsgPageState createState() => _MsgPageState();
}

class _MsgPageState extends State<MsgPage> {
  int select = 0;

  @override
  Widget build(BuildContext context) {
    Widget head = TikTokSwitchAppbar(
      index: select,
      list: ['消息'],
      onSwitch: (i) => setState(() => select = i),
    );
    Widget topButtons = Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _TopIconTextButton(
            title: '粉丝',
            icon: Icons.person,
            color: Colors.indigo,
            color2: Colors.green,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (cxt) => MsgDetailListPage(
                    title: '粉丝',
                    msgTitle: '你的粉丝',
                    msgDesc: '我是你的粉丝',
                  ),
                ),
              );
            },
          ),
          _TopIconTextButton(
            title: '赞',
            icon: Icons.golf_course,
            color: Colors.teal,
            color2: Colors.blue,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (cxt) => MsgDetailListPage(
                    title: '赞',
                    msgTitle: '你的粉丝',
                    msgDesc: '给你点了个赞',
                  ),
                ),
              );
            },
          ),
          _TopIconTextButton(
            title: '@',
            icon: Icons.people,
            color: Colors.deepPurple,
            color2: Colors.pink,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (cxt) => MsgDetailListPage(
                    title: '@',
                    msgTitle: '你的粉丝',
                    msgDesc: 'Ta提到了你',
                    reverse: true,
                  ),
                ),
              );
            },
          ),
          _TopIconTextButton(
            title: '评论',
            icon: Icons.mode_comment,
            color: Colors.red,
            color2: Colors.amber,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (cxt) => MsgDetailListPage(
                    title: '评论',
                    msgTitle: '老铁双击666啊',
                    msgDesc: '你的粉丝',
                    reverse: true,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
    //以下是改动部分


    Widget _buildCarouselItem(String imagePath, String avatarPath, String userName, String description) { // 添加 avatarPath 参数
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: SizedBox(
                  width: 300,
                  height: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(avatarPath), // 使用 avatarPath 参数
                      ),
                      SizedBox(height: 32),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(description),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('关闭'),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          // 使用 ClipRRect 裁剪图片
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    Widget ad = Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16.0 / 9.0, // 调整宽高比，例如 16:9
        child: CarouselSlider(
          options: CarouselOptions(
            height: null,
            autoPlay: true,
            viewportFraction: 1.0,
          ),
          items: [
            _buildCarouselItem('assets/images/1.png', 'assets/images/avatar1.png', '用户1', '这是一段介绍'), // 传递头像图片路径
            _buildCarouselItem('assets/images/test2.jpg', 'assets/images/avatar2.png', '用户2', '这是另一段介绍'), // 传递头像图片路径
            _buildCarouselItem('assets/images/test3.jpg', 'assets/images/avatar3.png', '用户3', '这是第三段介绍'), // 传递头像图片路径
            _buildCarouselItem('assets/images/test4.jpg', 'assets/images/avatar4.png', '用户4', '这是第四段介绍'), // 传递头像图片路径
          ].toList(),
        ),
      ),
    );


    //改动部分结束
    Widget body = Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: <Widget>[
          topButtons,
          ad,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '系统',
              style: StandardTextStyle.smallWithOpacity,
            ),
          ),
          // 替换原来的 UserMsgRow() 为动态生成的私信列表
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '私信',
              style: StandardTextStyle.smallWithOpacity,
            ),
          ),
          ...MessageStore.getUsersWithMessages().map((userName) {
            final user = MessageStore.getUser(userName);
            final lastMessage = MessageStore.getLastMessage(userName);
            return UserMsgRow(
              lead: CircleAvatar(
                backgroundImage: NetworkImage(user['image']),
              ),
              title: user['name'],
              desc: lastMessage['text'],
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MessagePage(
                      job: JobPost(
                        image: user['image'] ?? 'https://example.com/default-image.jpg',
                        company: user['company'] ?? 'Unknown Company',
                        title: user['position'] ?? 'Unknown Position',
                        salary: user['salary'] ?? 'Not specified',
                        description: user['description'] ?? 'No description available',
                        videoUrl: user['videoUrl'] ?? 'https://example.com/default-video.mp4',
                        location: user['location'] ?? 'Unknown Location',
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ],
      ),
    );
    body = Container(
      color: ColorPlate.back1,
      child: Column(
        children: <Widget>[
          head,
          body,
        ],
      ),
    );
    return body;
  }
}

class _TopIconTextButton extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final Color color2;
  final String? title;
  final Function? onTap;

  const _TopIconTextButton({
    Key? key,
    this.icon,
    this.color,
    this.title,
    this.color2 = Colors.white,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var iconContainer = Container(
      margin: EdgeInsets.all(6),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            color2,
            color!,
          ],
          stops: [0.1, 0.8],
        ),
      ),
      child: Icon(
        icon,
      ),
    );
    Widget body = Column(
      children: <Widget>[
        iconContainer,
        Text(
          title!,
          style: StandardTextStyle.small,
        )
      ],
    );
    body = Tapped(
      child: body,
      onTap: onTap,
    );
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: body,
      ),
    );
  }
}
