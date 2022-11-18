import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  String text;
  double fontSize;
  double height;
  FontWeight fontWeight;
  Color color;
  TextAlign? textAlign;
  int? maxLines;
  TextOverflow? textOverFlow;
  ThemeData themeData = ThemeData();
  CommonText({
    Key? key,
    required this.text,
    this.fontSize = 15,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.textAlign,
    this.maxLines,
    this.textOverFlow,
    this.height = 1.1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverFlow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        color: color,
      ),
    );
  }
}
