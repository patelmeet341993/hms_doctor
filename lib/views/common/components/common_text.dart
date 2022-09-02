import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  String text;
  double fontSize;
  Color color;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  int? maxLines;
  TextOverflow? textOverFlow;
  CommonText({Key? key, required this.text,this.fontSize=15,this.fontWeight,this.color= Colors.blue,this.textAlign,this.maxLines,this.textOverFlow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverFlow,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
