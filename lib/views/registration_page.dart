
import 'package:flutter/material.dart';
import 'welcome_page.dart';  // 添加这行
class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Achieve\nYour Career\nPassion Now',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3932),
                    height: 1.2,
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
                SizedBox(height: 32),
                _buildSocialButton(
                  icon: Icons.g_mobiledata,
                  text: 'Continue with Google',
                  color: Colors.blue,
                  onPressed: () {
                    // Handle Google login
                  },
                ),
                SizedBox(height: 16),
                _buildSocialButton(
                  icon: Icons.link,
                  text: 'Continue with LinkedIn',
                  color: Colors.lightBlue,
                  onPressed: () {
                    // Handle LinkedIn login
                  },
                ),
                SizedBox(height: 24),
                Center(
                  child: Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                _buildTextField(hintText: 'Your email address'),
                SizedBox(height: 16),
                _buildTextField(hintText: 'Set your password', obscureText: true),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the WelcomePage
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: Text(
                    'Register',
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
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(width: 12),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hintText, bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
    );
  }
}
