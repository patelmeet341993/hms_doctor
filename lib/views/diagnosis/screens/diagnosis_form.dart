import 'package:doctor/configs/constants.dart';
import 'package:doctor/views/common/components/common_text_form_field.dart';
import 'package:doctor/views/common/components/profile_picture_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../configs/app_strings.dart';
import '../../../models/visit_model/prescription/prescription_model.dart';
import '../../../packages/flux/widgets/button/button.dart';
import '../../../packages/flux/widgets/text/text.dart';
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
  final GlobalKey<FormState> _billFormKey = GlobalKey<FormState>();
  TextEditingController diagnosisTextController = TextEditingController();
  TextEditingController dietInstructionTextController = TextEditingController();
  TextEditingController billTextController = TextEditingController();
  TextEditingController discountTextController = TextEditingController();
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getPatientInfo(),
                const SizedBox(height: 10,),
                getTextFieldWithTitle(title: "Description",controller: diagnosisTextController),
                const SizedBox(height: 10,),
                /*getTextFieldWithTitle(title: "Diet instructions",controller: dietInstructionTextController),
                const SizedBox(height: 10,),*/
                getMedicineDetails(),
                const SizedBox(
                  height: 10,
                ),
                getVisitBill(),
                getEndVisitButton(),
              ],
            ),
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

  Widget getMedicineDetails(){
    return Column(
      children: [
        getTitleWithAddButton(
            title: AppStrings.medicinePrescription,
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
            }
            ),
        const SizedBox(height: 10,),
        prescriptionList.length>0?getPrescriptionTable():SizedBox.shrink(),
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

  Widget getVisitBill(){
    return Column(
      children: [
        getTitleWithAddButton(
            title: AppStrings.visitBill,
          onTap: ()async{
            List list = await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context){
                  return visitBillingDialog();
                });
              if (list[0] == true) {
                setState(() {});
              }
          }
        ),
        const SizedBox(height: 10,),
        billTextController.text.trim().isNotEmpty?getBillDetails():const SizedBox.shrink(),
      ],
    );
  }

  Widget getBillDetails(){
    double discount  = (discountTextController.text.isNotEmpty?double.parse(discountTextController.text):0);
    double total = double.parse(billTextController.text)-discount;
    return Column(
      children: [
        getBillRows(title:AppStrings.consultancyFee,amount: billTextController.text),
        SizedBox(height: 10,),
        getBillRows(title:AppStrings.discountPrice,amount: "-$discount"),
        SizedBox(height: 10,),
        Divider(),
        getBillRows(title:AppStrings.totalPrice,amount: "$total"),
      ],
    );
  }

  Widget getBillRows({required String title , required String amount}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: themeData.textTheme.headline6,),
        Text(amount,style: themeData.textTheme.headline6,),
      ],
    );
  }

  Widget getTitleWithAddButton({required String title,void Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: themeData.textTheme.headline6,),
        InkWell(
          onTap: onTap,
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

  Widget getEndVisitButton(){
    return FxButton.small(
      block: true,
      borderRadiusAll: 4,
      buttonType: FxButtonType.outlined,
      splashColor: themeData.colorScheme.primary.withAlpha(60),
      borderColor: themeData.primaryColor,
      onPressed: () {
      },
      elevation: 0,
      child: FxText.bodyMedium(
      AppStrings.endVisit,
      color: themeData.primaryColor,
      ),
    );
  }

  Widget visitBillingDialog(){
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Form(
          key: _billFormKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                getTextEditingFieldWithTitle(
                  title: AppStrings.consultancyFee,
                  controller: billTextController,
                  hintText: AppStrings.consultancyFee,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppStrings.enterFee;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                getTextEditingFieldWithTitle(title: AppStrings.discountPrice,controller: discountTextController,hintText: AppStrings.discountPrice),
                const SizedBox(height: 10,),
                getLastButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTextEditingFieldWithTitle({required String title,required TextEditingController controller , String? hintText, String? Function(String?)? validator}){
    return Row(
      children: [
        Text(title,style: themeData.textTheme.headline6,),
        const SizedBox(width: 15,),
        Expanded(
            child: CommonTextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly
              ],
              hintText: hintText,
              validator: validator,
            ),
        ),

      ],
    );
  }

  Widget getLastButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: FxButton.small(
            borderRadiusAll: 4,
            buttonType: FxButtonType.outlined,
            splashColor: themeData.colorScheme.primary.withAlpha(60),
            borderColor: themeData.primaryColor,
            onPressed: () {
              Navigator.pop(context,[false]);
            },
            elevation: 0,
            child: FxText.bodyMedium(
              AppStrings.cancel,
              color: themeData.primaryColor,
            ),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: FxButton.small(
            borderRadiusAll: 4,
            backgroundColor: themeData.primaryColor,
            onPressed: () {
              if(_billFormKey.currentState!.validate()){
                Navigator.pop(context,[true]);
              }
            },
            elevation: 0,
            splashColor: themeData.colorScheme.onPrimary.withAlpha(60),
            child: FxText.bodyMedium(
              AppStrings.done,
              color: themeData.colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}


