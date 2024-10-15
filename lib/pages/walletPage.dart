import 'package:flutter/material.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/views/topToolRow.dart';
import 'package:flutter_tiktok/pages/rechargePage.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPlate.back1,
      body: SafeArea(
        child: Column(
          children: [
            TopToolRow(
              canPop: true,
              onPop: () => Navigator.of(context).pop(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '钱包',
                    style: StandardTextStyle.big,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '当前余额',
                          style: StandardTextStyle.normal,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '¥ 100.00',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorPlate.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RechargePage()),
                      );
                    },
                    child: Text('充值'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPlate.orange,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
