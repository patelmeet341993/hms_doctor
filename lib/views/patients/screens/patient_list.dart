import 'package:flutter/material.dart';

class PatientList extends StatefulWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {

  late ThemeData themeData;


  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
     /* appBar: AppBar(
        centerTitle: true,
        title: Text("Patients",style: themeData.textTheme.headline5,),
      ),*/
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[]
        ),
      ),
    );
  }
}
