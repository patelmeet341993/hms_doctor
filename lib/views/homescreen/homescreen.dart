import 'package:doctor/views/common/components/common_button.dart';
import 'package:doctor/views/diagnosis/screens/diagnosis_form.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: getMyBody(),
    );
  }
  Widget getMyBody(){
    return Row(
      children: [
        CommonButtonWithArrow(text: "diagnosisScreen",onPressed: (){
          Navigator.pushNamed(context, DiagnosisForm.routeName);
        },),

      ],
    );
  }

}
