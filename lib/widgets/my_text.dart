import 'package:bing_flutter/my_all_imports.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class MyText extends StatelessWidget {
  final String content;
  double size;
  Color color;

  MyText({this.content = 'test content', this.size, this.color}) {
    size ??= 16.sp;
    color ??= Colors.grey[800];
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(fontSize: size, color: color),
    );
  }
}
