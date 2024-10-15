import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/views/tilTokAppBar.dart';
import 'package:flutter_tiktok/views/userMsgRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok/pages/messagePage.dart';
import 'package:flutter_tiktok/models/message_store.dart'; // 添加这行
import 'package:flutter_tiktok/models/job_post.dart';

class MsgDetailListPage extends StatefulWidget {
  final String? title;
  final String? msgTitle;
  final String? msgDesc;
  final bool reverse; // 移除问号，使其非空

  const MsgDetailListPage({
    Key? key,
    this.title,
    this.msgTitle,
    this.msgDesc,
    this.reverse = false, // 提供默认值
  }) : super(key: key);

  @override
  _MsgDetailListPageState createState() => _MsgDetailListPageState();
}

class _MsgDetailListPageState extends State<MsgDetailListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息'),
      ),
      body: ListView(
        children: [
          // 现有的图标行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconButton('粉丝', Icons.person_add),
              _buildIconButton('赞', Icons.thumb_up),
              _buildIconButton('@', Icons.alternate_email),
              _buildIconButton('评论', Icons.comment),
            ],
          ),
          Divider(),
          // 私信列表
          ...MessageStore.getUsersWithMessages().map((userName) {
            final user = MessageStore.getUser(userName);
            final lastMessage = MessageStore.getLastMessage(userName);
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user['image']),
              ),
              title: Text(user['name']),
              subtitle: Text(lastMessage['text']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagePage(
                      job: JobPost(
                        image: user['image'] ?? 'https://example.com/default.jpg',
                        company: user['company'] ?? user['name'],
                        title: user['position'] ?? '未知职位',
                        salary: user['salary'] ?? '待定',
                        description: user['description'] ?? '暂无描述',
                        videoUrl: user['video_url'] ?? '',
                        location: user['location'] ?? '未知地点',
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
          Divider(),
          // 系统通知
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('系统通知'),
            onTap: () {
              // 处理系统通知的点击事件
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(String label, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}

// 创建一个新的私信列表页面
class PrivateMessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('私信'),
      ),
      body: ListView(
        children: MessageStore.getUsersWithMessages().map((userName) {
          final user = MessageStore.getUser(userName);
          final lastMessage = MessageStore.getLastMessage(userName);
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user['image']),
            ),
            title: Text(user['name']),
            subtitle: Text(lastMessage['text']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagePage(
                    job: JobPost(
                      image: user['image'] ?? 'https://example.com/default.jpg',
                      company: user['company'] ?? user['name'],
                      title: user['position'] ?? '未知职位',
                      salary: user['salary'] ?? '待定',
                      description: user['description'] ?? '暂无描述',
                      videoUrl: user['video_url'] ?? '',
                      location: user['location'] ?? '未知地点',
                    ),
                  ),
                )
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

JobPost job = JobPost.fromJson({
  'image': 'https://example.com/image.jpg',
  'company': '示例公司',
  'title': '示例职位',
  'salary': '面议',
  'description': '是一个示例职位描述。',
  'video_url': 'https://example.com/video.mp4',
  'location': '示例地点',
});

// 使用 job 对象替代原来的 Map

