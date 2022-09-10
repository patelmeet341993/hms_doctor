import 'package:doctor/configs/constants.dart';
import 'package:doctor/views/common/components/common_text_form_field.dart';
import 'package:doctor/views/common/components/profile_picture_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../models/visit_model/prescription/prescription_model.dart';
import '../../../utils/logger_service.dart';
import 'get_medicine_dialog.dart';

class DiagnosisForm extends StatefulWidget {
  static const String routeName = "/DiagnosisForm";

  const DiagnosisForm({Key? key}) : super(key: key);

  @override
  State<DiagnosisForm> createState() => _DiagnosisFormState();
}

class _DiagnosisFormState extends State<DiagnosisForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController diagnosisTextController = TextEditingController();
  TextEditingController dietInstructionTextController = TextEditingController();
  List<PrescriptionModel> prescriptionList=[];

  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      /*appBar: AppBar(
        centerTitle: true,
        title: Text("Diagnosis",style: themeData.textTheme.headline5,),
      ),*/
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getPatientInfo(),
              const SizedBox(height: 10,),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getTextFieldWithTitle(title: "Description",controller: diagnosisTextController),
                    const SizedBox(height: 10,),
                    /*getTextFieldWithTitle(title: "Diet instructions",controller: dietInstructionTextController),
                    const SizedBox(height: 10,),*/
                    getMedicineDetails(),
                    const SizedBox(height: 10,),
                    getPrescriptionTable(),
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

  Widget getMedicineDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Medicine Prescription",style: themeData.textTheme.headline6,),
        InkWell(
          onTap: () async{
            List list = await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context){
                  return const GetMedicineDialog();
            });
            if (list[0] == true) {
              prescriptionList.add(list[1]);
              setState(() {});
            }
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: themeData.primaryColor.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Icon(FontAwesomeIcons.plus,size: 16,color: themeData.primaryColor,)
            //Text("Add Medicine",style: TextStyle(fontSize: 14,color: themeData.primaryColor,fontWeight: FontWeight.w600),),

          ),
        ),
      ],
    );
  }

  Widget getPrescriptionTable(){
    return Center(
      child: DataTable(
        headingRowHeight: 30,
        headingRowColor: MaterialStateProperty.resolveWith(
                (states) => themeData.primaryColor.withOpacity(0.3)
        ),
        columnSpacing: 20,
        columns: [
          DataColumn(label:Text("Medicine",style: themeData.textTheme.bodyText1,),),
          DataColumn(label:Text("Quantity",style: themeData.textTheme.bodyText1,)),
          DataColumn(label:Text("Time",style: themeData.textTheme.bodyText1,)),
          DataColumn(label:Text("Instruction",style: themeData.textTheme.bodyText1,)),
      ],
        rows: List.generate(prescriptionList.length, (index) => getDataRow(prescriptionModel: prescriptionList[index]))
      ),
    );
  }

  DataRow getDataRow({required PrescriptionModel prescriptionModel}){
    String time="";
    for (var element in prescriptionModel.doses) {
      time += "${element.doseTime},";
    }
    Log().d("total dose string: ${prescriptionModel.totalDose + (prescriptionModel.medicineType==MedicineType.syrup?" ml":"")}");
    return DataRow(
        cells: [
          DataCell(SizedBox(
            width: 80,
            child: Text(prescriptionModel.medicineName,
              style: themeData.textTheme.bodySmall,
              overflow: TextOverflow.visible,
              softWrap: true,),
          ),),
          DataCell(SizedBox(
            width: 50,
            child: Text(prescriptionModel.totalDose,
              style: themeData.textTheme.bodySmall,
              overflow: TextOverflow.visible,
              softWrap: true,),
          ),),
          DataCell(SizedBox(
            width: 80,
            child: Text(time,
              style: themeData.textTheme.bodySmall,
              overflow: TextOverflow.visible,
              softWrap: true,),
          ),),
          DataCell(SizedBox(
            width: 80,
            child: Text(prescriptionModel.instructions,
              style: themeData.textTheme.bodySmall,
              overflow: TextOverflow.visible,
              softWrap: true,),
          ),),
        ]
    );
  }

  Widget getTextFieldWithTitle({required String title,required TextEditingController controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: themeData.textTheme.headline6,),
        const SizedBox(height: 4,),
        CommonTextFormField(controller: controller,maxLines: 5,minLines: 5,),
      ],
    );
  }

  Widget getKeyValueWidget({required String key , required String value}){
    return Row(
      children: [
        Text("$key : ",style: themeData.textTheme.bodyText1,),
        Text(value,style: themeData.textTheme.bodyText1?.merge(TextStyle(color: themeData.primaryColor))),
      ],
    );
  }


}


