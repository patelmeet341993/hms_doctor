import 'package:doctor/configs/constants.dart';
import 'package:doctor/views/common/components/common_text_form_field.dart';
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
  TextEditingController diagnosisTextController = TextEditingController();

  late ThemeData themeData;




  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Diagnosis",style: themeData.textTheme.headline5,),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getPatientInfo(),
            const SizedBox(height: 10,),
            Form(
              key: _formKey,
              child: Column(
                children: [

                  CommonTextFormField(controller: diagnosisTextController),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }

  Widget getPatientInfo(){
    return Row(
      children: [
        ProfilePictureCircle(imageUrl: noUserImageUrl),
        const SizedBox(width: 20,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getKeyValueWidget(key: "Id" , value: "D0014352"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getKeyValueWidget(key: "Blood Group" , value: "B +"),
                  getKeyValueWidget(key: "Weight" , value: "50 Kg"),
                  Container(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getKeyValueWidget({required String key , required String value}){
    return Row(
      children: [
        Text("$key : ",style: themeData.textTheme.bodyText1,),
        Text(value,style: themeData.textTheme.bodyText1?.merge(TextStyle(color: themeData.colorScheme.secondary))),
      ],
    );
  }

}
