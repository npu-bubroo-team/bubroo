import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter/material.dart';

class SelectText extends StatelessWidget {
  const SelectText({
    Key? key,
    this.isSelect = true,
    this.title,
  }) : super(key: key);

  final bool isSelect;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      color: Colors.black.withOpacity(0),
      child: Text(
        title ?? '??',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelect ? Colors.black : Colors.grey,
          fontSize: isSelect ? StandardTextStyle.big.fontSize : StandardTextStyle.bigWithOpacity.fontSize,
          fontWeight: isSelect ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
