import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormField extends StatelessWidget {
  TextEditingController controller;
  String? hintText;
  int? maxLines;
  int? minLines;
  IconData? suffixIcon,prefixIcon;
  Function()? suffixOnTap,prefixOnTap;
  String? Function(String?)? validator;
  List<TextInputFormatter> inputFormatter = [];
  TextInputType? keyboardType;

  ThemeData themeData = ThemeData();
   CommonTextFormField({
    Key? key,
     required this.controller,
     this.hintText,
     this.maxLines=1,
     this.minLines=1,
     this.suffixIcon,
     this.suffixOnTap,
     this.prefixIcon,
     this.prefixOnTap,
     this.inputFormatter = const [],
     this.keyboardType,
     this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return TextFormField(
      obscureText:false,
      enableInteractiveSelection: false,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
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
        hintText: hintText??" ",
        filled: true,
        suffix: suffixIcon!=null?InkWell(
          onTap: suffixOnTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Icon(suffixIcon,size: 20,color:themeData.primaryColor),
          ),
        ):null,
        prefix: prefixIcon!=null?InkWell(
          onTap: prefixOnTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Icon(prefixIcon,size: 20,color:themeData.primaryColor),
          ),
        ):null,
      ),
      validator: validator,
      inputFormatters: inputFormatter,
      maxLines: maxLines,
      minLines: minLines,
    );
  }
}
