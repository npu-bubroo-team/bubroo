import 'package:flutter_tiktok/models/job_post.dart';

class MessageStore {
  static final Map<String, List<Map<String, dynamic>>> _messages = {};
  static final List<Map<String, dynamic>> _users = [];
  static Map<String, List<Map<String, dynamic>>> conversations = {};

  static void addUser(Map<String, dynamic> user) {
    if (!_users.any((u) => u['name'] == user['name'])) {
      // 确保用户信息包含所有必要的字段
      user['company'] = user['company'] ?? user['name'];
      user['position'] = user['position'] ?? '未知职位';
      user['salary'] = user['salary'] ?? '待定';
      user['description'] = user['description'] ?? '暂无描述';
      _users.add(user);
    }
  }

  static void addMessage(String companyName, Map<String, dynamic> message) {
    if (!_messages.containsKey(companyName)) {
      _messages[companyName] = [];
    }
    _messages[companyName]!.add(message);
  }

  static List<Map<String, dynamic>> getMessages(String companyName) {
    return _messages[companyName] ?? [];
  }

  static List<String> getUsersWithMessages() {
    return _messages.keys.toList();
  }

  static Map<String, dynamic> getUser(String userName) {
    return _users.firstWhere((user) => user['name'] == userName, orElse: () => {'name': userName, 'image': 'https://via.placeholder.com/150'});
  }

  static Map<String, dynamic> getLastMessage(String userName) {
    final messages = _messages[userName];
    return messages != null && messages.isNotEmpty ? messages.last : {'text': '暂无消息'};
  }

  static void addConversation(String company, JobPost job) {
    if (!conversations.containsKey(company)) {
      conversations[company] = [];
    }
    conversations[company]!.add({
      'isCompany': true,
      'message': '欢迎咨询关于 ${job.title} 职位的信息！',
      'timestamp': DateTime.now().toString(),
    });
  }
}
