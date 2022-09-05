import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  TextEditingController controller;
  String? hintText;
  ThemeData themeData = ThemeData();
  CommonTextFormField({Key? key,required this.controller,this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8)),
        hintText: hintText??"",
        filled: true,
      ),


    );
  }
}
