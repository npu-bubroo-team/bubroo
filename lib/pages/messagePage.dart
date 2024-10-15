import 'package:flutter/material.dart';
import 'package:flutter_tiktok/models/message_store.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/models/job_post.dart';

class MessagePage extends StatefulWidget {
  final JobPost job;

  MessagePage({required this.job});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late List<Map<String, dynamic>> messages;
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messages = MessageStore.getMessages(widget.job.company);
    if (messages.isEmpty) {
      // 如果没有消息，添加初始消息
      MessageStore.addMessage(widget.job.company, {
        'text': '您好，我对这个${widget.job.title}职位很感兴趣。请问还有更多详细信息吗？',
        'isMe': true,
        'timestamp': DateTime.now().toString(),
      });
      messages = MessageStore.getMessages(widget.job.company);
    }
    // 添加自动回复
    _sendAutoReply();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job.company),
        backgroundColor: ColorPlate.back1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message['isMe'] ? Colors.blue : Colors.grey[700],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      message['text'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: ColorPlate.back1,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: '输入消息...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[800],
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: ColorPlate.back2,
    );
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        MessageStore.addMessage(widget.job.company, {
          'text': _messageController.text,
          'isMe': true,
          'timestamp': DateTime.now().toString(),
        });
        messages = MessageStore.getMessages(widget.job.company);
      });
      _messageController.clear();
      _scrollToBottom();
      
      // 添加延迟后的自动回复
      Future.delayed(Duration(seconds: 1), () {
        _sendAutoReply();
      });
    }
  }

  void _sendAutoReply() {
    final replyMessage = {
      'text': '感谢您对${widget.job.title}职位的兴趣。该职位需要相关领域的经验，薪资范围是${widget.job.salary}。如果您有更多问题，请随时询问。',
      'isMe': false,
      'timestamp': DateTime.now().toString(),
    };
    setState(() {
      messages.add(replyMessage);
    });

    // 再次滚动到底部以显示自动回复
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
