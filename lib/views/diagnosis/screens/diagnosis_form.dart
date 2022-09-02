import 'package:doctor/configs/constants.dart';
import 'package:doctor/views/common/components/common_text.dart';
import 'package:doctor/views/common/components/profile_picture_circle.dart';
import 'package:flutter/material.dart';

class DiagnosisForm extends StatefulWidget {
  static const String routeName = "/DiagnosisForm";

  const DiagnosisForm({Key? key}) : super(key: key);

  @override
  State<DiagnosisForm> createState() => _DiagnosisFormState();
}

class _DiagnosisFormState extends State<DiagnosisForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CommonText(text: "Diagnosis"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getPatientInfo(),
              Form(
                key: _formKey,
                child: Column(
                  children: [

                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPatientInfo(){
    return Row(
      children: [
        ProfilePictureCircle(imageUrl: noUserImageUrl),
        const SizedBox(width: 10,),
        Column(
          children: [
            CommonText(text: "Name: patient Name"),

          ],
        ),
      ],
    );
  }

}
