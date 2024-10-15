import 'package:flutter/material.dart';
import 'mentor_intro_page.dart';  // 添加这行
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BUBROO', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3932),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'insert content here....',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF1E3932),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Question 1?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Eg....',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              ),
            ),
            Spacer(),
            ElevatedButton(
      onPressed: () {
        // Navigate to the MentorIntroPage
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MentorIntroPage()),
        );
      },
      child: Text(
        'Continue',
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFCD8D4E),
        minimumSize: Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
          ],
        ),
      ),
    );
  }
}