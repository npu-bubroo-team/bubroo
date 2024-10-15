import 'package:flutter/material.dart';
import 'company_match_page.dart';

class SuggestedMentorPage extends StatefulWidget {
  @override
  _SuggestedMentorPageState createState() => _SuggestedMentorPageState();
}

class _SuggestedMentorPageState extends State<SuggestedMentorPage> {
  int currentIndex = 0;
  List<bool> likedMentors = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {
              // Handle help action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suggested for you ${currentIndex + 1}/3',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                // Replace with actual image when available
                child: Icon(Icons.person, size: 100, color: Colors.grey[600]),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Daniels Tuscan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('working position title'),
            Text('highlighted skills'),
            Text('company info?'),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    // Handle switch action
                  },
                ),
                IconButton(
                  icon: Icon(
                    likedMentors[currentIndex] ? Icons.favorite : Icons.favorite_border,
                    color: likedMentors[currentIndex] ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      likedMentors[currentIndex] = !likedMentors[currentIndex];
                      if (likedMentors[currentIndex]) {
                        if (currentIndex < 2) {
                          currentIndex++;
                        } else {
                          // Navigate to CompanyMatchPage after liking 3 mentors
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CompanyMatchPage(),
                          ));
                        }
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for the next screen
class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Next Screen')),
      body: Center(child: Text('This is the next screen after liking 3 mentors')),
    );
  }
}