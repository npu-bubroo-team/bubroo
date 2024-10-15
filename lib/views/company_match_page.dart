import 'package:flutter/material.dart';
import 'package:flutter_tiktok/pages/homePage.dart';
class CompanyMatchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BUBROO', style: TextStyle(color: Colors.black)),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Those companies that matches your career goal is hiring',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3932),
                height: 1.2,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Change Content here::::Right support from career mentors. Right spot. Right appreciation to your time, lifestyle and career passion.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  label: Text('Back', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    // Handle View action
                    builder: (context) => HomePage(),
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