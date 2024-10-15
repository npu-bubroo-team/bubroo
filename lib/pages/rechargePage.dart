import 'package:flutter/material.dart';
import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/views/topToolRow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RechargePage extends StatelessWidget {
  const RechargePage({Key? key}) : super(key: key);

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
                    '充值',
                    style: StandardTextStyle.big,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '选择支付方式',
                    style: StandardTextStyle.normal,
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildPaymentMethod(FontAwesomeIcons.ccVisa, 'Visa'),
                      _buildPaymentMethod(FontAwesomeIcons.ccMastercard, 'Mastercard'),
                      _buildPaymentMethod(FontAwesomeIcons.ccPaypal, 'PayPal'),
                      _buildPaymentMethod(FontAwesomeIcons.alipay, 'Alipay'),
                      _buildPaymentMethod(FontAwesomeIcons.weixin, 'WeChat Pay'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(IconData icon, String name) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: ColorPlate.orange),
          SizedBox(height: 5),
          Text(name, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
