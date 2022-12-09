import 'package:doctor/packages/flux/flutx.dart';
import 'package:doctor/configs/app_strings.dart';
import 'package:doctor/views/common/components/get_key_value_widget.dart';
import 'package:flutter/material.dart';

class PatientList extends StatefulWidget {
  final String title;
  const PatientList({Key? key, this.title = AppStrings.patients}) : super(key: key);

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {

  late ThemeData themeData;


  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
     appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:List.generate(10, (index) => patientListCard())
          ),
        ),
      ),
    );
  }


  Widget patientListCard(){
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: FxCard(
        shadow: FxShadow(elevation: 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetKeyValueWidget(keyString: "Patient Id:", value: "D012254"),
                GetKeyValueWidget(keyString: "Patient Weight:", value: "50 kg"),
              ],
            ),
            SizedBox(height: 10,),
            Text("asdfjshegfndkxf kasgdfjsedfv kshifdhrg bskhfru idrhtgt swefe idheotg smbfie drhto awmnfeieshgir srngidrht",style: themeData.textTheme.bodyMedium,),
          ],
        ),
      ),
    );
  }


}
