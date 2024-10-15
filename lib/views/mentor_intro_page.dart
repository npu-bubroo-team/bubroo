import 'package:flutter/material.dart';
import 'suggested_mentor_page.dart';
class MentorIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BUBROO', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // 移除默认的返回按钮
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mentors for you to get started!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3932),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Right support from career mentors. Right spot. Right appreciation to your time, lifestyle and career passion.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            Spacer(), // 将按钮推到底部
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Back', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    // Handle View action
                    builder: (context) => SuggestedMentorPage(),
                    ));
                  },
                  child: Text('View', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}