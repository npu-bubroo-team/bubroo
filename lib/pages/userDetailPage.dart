import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter_tiktok/views/tilTokAppBar.dart';
import 'package:flutter/material.dart';
import 'package:tapped/tapped.dart';

class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  bool _isEditing = false;
  String _nickname = '朱二蛋的枯燥生活';
  String _phone = '186****7767';
  String _address = '深圳市南山区南海大道';
  String _age = '18';
  String _gender = '男';
  String _occupation = '总裁';

  @override
  Widget build(BuildContext context) {
    Widget head = TikTokAppbar(
      title: '用户',
    );
    var userHead = Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              '个人信息',
              style: StandardTextStyle.smallWithOpacity,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isEditing = !_isEditing;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              _isEditing ? '保存' : '修改',
              style: StandardTextStyle.smallWithOpacity.apply(
                color: ColorPlate.orange,
              ),
            ),
          ),
        )
      ],
    );
    Widget body = ListView(
      padding: EdgeInsets.only(
        bottom: 80 + MediaQuery.of(context).padding.bottom,
      ),
      children: <Widget>[
        userHead,
        _UserInfoRow(
          title: '昵称',
          rightIcon: _isEditing
              ? TextField(
                  controller: TextEditingController(text: _nickname),
                  onChanged: (value) => _nickname = value,
                  style: StandardTextStyle.small,
                )
              : Text(_nickname, style: StandardTextStyle.small),
        ),
        _UserInfoRow(
          title: '头像',
          rightIcon: Text(
            '上传',
            style: StandardTextStyle.small,
          ),
        ),
        _UserInfoRow(
          title: '手机绑定',
          rightIcon: _isEditing
              ? TextField(
                  controller: TextEditingController(text: _phone),
                  onChanged: (value) => _phone = value,
                  style: StandardTextStyle.small,
                )
              : Text(_phone, style: StandardTextStyle.small),
        ),
        _UserInfoRow(
          title: '地址',
          rightIcon: _isEditing
              ? TextField(
                  controller: TextEditingController(text: _address),
                  onChanged: (value) => _address = value,
                  style: StandardTextStyle.small,
                )
              : Text(_address, style: StandardTextStyle.small),
        ),
        _UserInfoRow(
          title: '年龄',
          rightIcon: _isEditing
              ? TextField(
                  controller: TextEditingController(text: _age),
                  onChanged: (value) => _age = value,
                  style: StandardTextStyle.small,
                )
              : Text(_age, style: StandardTextStyle.small),
        ),
        _UserInfoRow(
          title: '用户性别',
          rightIcon: _isEditing
              ? TextField(
                  controller: TextEditingController(text: _gender),
                  onChanged: (value) => _gender = value,
                  style: StandardTextStyle.small,
                )
              : Text(_gender, style: StandardTextStyle.small),
        ),
        _UserInfoRow(
          title: '职业',
          rightIcon: _isEditing
              ? TextField(
                  controller: TextEditingController(text: _occupation),
                  onChanged: (value) => _occupation = value,
                  style: StandardTextStyle.small,
                )
              : Text(_occupation, style: StandardTextStyle.small),
        ),
      ],
    );
    body = Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: body,
      ),
    );
    return Scaffold(
      body: Container(
        color: ColorPlate.back1,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            head,
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  _UserInfoRow({
    this.icon,
    this.title,
    this.rightIcon,
    this.onTap,
  });

  final Widget? icon;
  final Widget? rightIcon;
  final String? title;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    Widget iconImg = Container(
      height: 24,
      width: 24,
      child: icon,
    );

    Widget row = Container(
      height: 48,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border(
          bottom: BorderSide(color: Colors.white12),
        ),
      ),
      child: Row(
        children: <Widget>[
          icon != null ? iconImg : Container(),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                title!,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            child: rightIcon ?? Container(),
          ),
        ],
      ),
    );
    row = Tapped(
      onTap: onTap,
      child: row,
    );

    return row;
  }
}
