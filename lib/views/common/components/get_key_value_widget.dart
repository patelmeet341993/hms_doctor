import 'package:flutter/material.dart';

class GetKeyValueWidget extends StatelessWidget {
  String keyString,value;
  ThemeData themeData = ThemeData();

  GetKeyValueWidget({Key? key,required this.keyString , required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Row(
      children: [
        Text("$keyString : ",style: themeData.textTheme.bodyText1,),
        Text(value,style: themeData.textTheme.bodyText1?.merge(TextStyle(color: themeData.primaryColor))),
      ],
    );
  }
}
