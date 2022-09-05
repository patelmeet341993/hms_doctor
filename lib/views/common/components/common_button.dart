import 'package:flutter/material.dart';

class CommonButtonWithArrow extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final bool isForwardArrowVisible;
  final double fontSize;

  const CommonButtonWithArrow(
      {
        this.onPressed,
        required this.text,
        this.backgroundColor =  Colors.white,
        this.isForwardArrowVisible = false,
        this.fontSize=14
      });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal:0 ),
        decoration: BoxDecoration(
            color:backgroundColor,
            borderRadius: BorderRadius.circular(30)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8,),
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                text,
                style:  TextStyle(
                    fontSize: fontSize,
                    color: Colors.blue
                ),
              ),
            ),
            Visibility(
              visible: isForwardArrowVisible,
              child: const Padding(
                padding:  EdgeInsets.only(right: 4.0),
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
