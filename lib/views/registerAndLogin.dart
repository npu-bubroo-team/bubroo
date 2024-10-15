import 'package:flutter/material.dart';
import 'package:flutter_tiktok/views/registration_page.dart';

class AndroidComScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 使用 MediaQuery 获取屏幕尺寸
    final screenSize = MediaQuery.of(context).size;
    
    // 计算宽高比
    final aspectRatio = 412 / 917;
    
    return Scaffold(
      body: Container(
        // 使用 LayoutBuilder 来适应不同的屏幕尺寸
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = width / aspectRatio;
            
            // 如果计算出的高度超过了屏幕高度，就以屏幕高度为准
            if (height > constraints.maxHeight) {
              height = constraints.maxHeight;
              width = height * aspectRatio;
            }
            
            return Center(
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFDF6),
                  borderRadius: BorderRadius.circular(16 * (width / 412)), // 保持圆角比例
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16 * (width / 412)),
                  child: Stack(
                    children: [
                      // 添加新的子部件
                      Positioned.fill(
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  'vision image page',
                                  style: TextStyle(
                                    fontSize: 18 * (width / 412),
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16 * (width / 412)),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // 处理注册逻辑
                                    },
                                    child: Text('Register'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFE9B97C),
                                      minimumSize: Size(double.infinity, 48 * (width / 412)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8 * (width / 412)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16 * (width / 412)),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => RegistrationPage()),
                                      );
                                    },
                                    child: Text('Log in'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFCD8D4E),
                                      minimumSize: Size(double.infinity, 48 * (width / 412)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8 * (width / 412)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
