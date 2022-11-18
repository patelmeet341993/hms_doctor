import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/configs/app_theme.dart';
import 'package:doctor/configs/constants.dart';
import 'package:doctor/models/admin_user_model.dart';
import 'package:doctor/models/visit_model/diagnosis%20and%20prescription/diagnosis_model.dart';
import 'package:doctor/models/visit_model/diagnosis%20and%20prescription/vitals_model.dart';
import 'package:doctor/models/visit_model/patient_meta_model.dart';
import 'package:doctor/providers/admin_user_provider.dart';
import 'package:doctor/utils/my_toast.dart';
import 'package:doctor/utils/parsing_helper.dart';
import 'package:doctor/views/common/components/common_text.dart';
import 'package:doctor/views/common/components/common_text_form_field.dart';
import 'package:doctor/views/common/components/modal_progress_hud.dart';
import 'package:doctor/views/common/components/profile_picture_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../configs/app_strings.dart';
import '../../../controllers/firestore_controller.dart';
import '../../../models/visit_model/prescription/prescription_model.dart';
import '../../../models/visit_model/visit_billings/visit_billing_model.dart';
import '../../../models/visit_model/visit_model.dart';
import '../../../packages/flux/widgets/button/button.dart';
import '../../../packages/flux/widgets/text/text.dart';
import '../../../utils/logger_service.dart';
import '../../../utils/my_utils.dart';
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

  bool isLoading = false;
  double price = 0,discount = 0,total = 0;

  TextEditingController diagnosisTextController = TextEditingController();
  TextEditingController instructionTextController = TextEditingController();
  TextEditingController complaintsTextController = TextEditingController();
  TextEditingController billTextController = TextEditingController();
  TextEditingController discountTextController = TextEditingController();

  TextEditingController heightTextController = TextEditingController();
  TextEditingController weightTextController = TextEditingController();
  TextEditingController pulseTextController = TextEditingController();
  TextEditingController temperatureTextController = TextEditingController();
  TextEditingController bPSystolicTextController = TextEditingController();
  TextEditingController bPDiastolicTextController = TextEditingController();
  TextEditingController bloodGroupTextController = TextEditingController();


  List<PrescriptionModel> prescriptionList=[];

  late ThemeData themeData;

  Future uploadVisit()
  async
  {
    AdminUserModel? doctor = Provider.of<AdminUserProvider>(context,listen: false).getAdminUserModel();

    if(doctor == null){
      MyToast.showError("Please Login to create visit", context);
      return;
    }

    Timestamp time = Timestamp.now();

    VitalsModel vitalsModel = VitalsModel(
      height: ParsingHelper.parseDoubleMethod(heightTextController.text),
      weight: ParsingHelper.parseDoubleMethod(weightTextController.text),
      pulse: ParsingHelper.parseDoubleMethod(pulseTextController.text),
      temperature: ParsingHelper.parseDoubleMethod(temperatureTextController.text),
      bpSystolic: ParsingHelper.parseDoubleMethod(bPSystolicTextController.text),
      bpDiastolic: ParsingHelper.parseDoubleMethod(bPDiastolicTextController.text),
      bloodGroup: bloodGroupTextController.text,
    );

    PatientMetaModel patientMetaModel = PatientMetaModel(
      id: "d86460602a8411edb04ead939aa5bd25",
      name: "Viren",
      gender: "Male",
      bloodGroup: "B+",
      totalVisits: 120,
      userMobile: "9726540099",
      dateOfBirth: Timestamp.now(),
    );

    DiagnosisModel diagnosisModel = DiagnosisModel(
      diagnosisDescription: diagnosisTextController.text,
      doctorId: doctor.id,
      prescription: prescriptionList,
    );

    VisitBillingModel visitBillingModel = VisitBillingModel(
      doctorId: doctor.id,
      createdTime:time,
      discount: discount,
      fee: price,
      totalFees: total,
      paymentMode: PaymentModes.cash
    );

    String id = MyUtils.getUniqueIdFromUuid();

    VisitModel visitModel = VisitModel(
      active: true,
      patientId: "d86460602a8411edb04ead939aa5bd25",
      createdTime: time,
      id: id,
      vitals: vitalsModel,
      diagnosis: [diagnosisModel],
      visitBillings: {doctor.id : visitBillingModel},
      patientMetaModel: patientMetaModel,
    );

    await FirestoreController().firestore.collection(FirebaseNodes.visitsCollection).doc(visitModel.id).set(visitModel.toMap()).then((value) {
      Log().i("Visit Created Successfully with id:${visitModel.id}");
    })
        .catchError((e, s) {
      Log().e(e, s);
    });

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: SpinKitCircle(color: themeData.primaryColor,),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: getBody(),
            ),
          ),
        ),
      ),
    );
  }

  Widget getBody(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getPatientInfo(),
        Divider(),
        const SizedBox(height: 10,),
        getVitals(),
        const SizedBox(height: 10,),
        getTextFieldWithTitle(title: "Complaints",controller: complaintsTextController),
        const SizedBox(height: 10,),
        getTextFieldWithTitle(title: "Diagnosis",controller: diagnosisTextController),
        const SizedBox(height: 10,),
        getMedicineDetails(),
        const SizedBox(height: 10,),
        getTextFieldWithTitle(title: "Instructions",controller: instructionTextController),
        const SizedBox(height: 10,),
        getVisitBill(),
        getEndVisitButton(),
      ],
    );
  }

  Widget getPatientInfo(){
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ProfilePictureCircle(imageUrl: noUserImageUrl,height: 30,width: 30,),
            const SizedBox(width: 10,),
            Expanded(
              child:CommonText(text: "Mr. xyz pqr"),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        SizedBox(
          height: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonText(text: "Hhsdv934756JawyufdguL"),
              const VerticalDivider(color: Colors.black,width: 8),
              CommonText(text: "66y"),
              const VerticalDivider(color: Colors.black,width: 8),
              CommonText(text: "Male"),
              const VerticalDivider(color: Colors.black,width: 8),
              CommonText(text: "9355684965")
            ],
          ),
        )
      ],
    );
  }

  Widget getVitals() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(child: getSingleVitalValue(title: "Height", textEditingController: heightTextController, suffix: "cm")),
            const SizedBox(width: 10,),
            Expanded(child: getSingleVitalValue(title: "Weight", textEditingController: weightTextController, suffix: "Kg")),
            const SizedBox(width: 10,),
            Expanded(child: getSingleVitalValue(title: "Pulse", textEditingController: pulseTextController, suffix: "bpm")),
            const SizedBox(width: 10,),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: getSingleVitalValue(title: "Temp.", textEditingController: temperatureTextController,suffix:  "F")),
            const SizedBox(width: 10,),
            CommonText(text: "BP"),
            const SizedBox(width: 3,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.lightTheme.primaryColor.withOpacity(.06),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: AppTheme.lightTheme.primaryColor)
                ),
                child: Row(
                  children: [
                    Expanded(child: CommonTextFormField(controller: bPSystolicTextController,transparent: true,keyboardType: TextInputType.number,)),
                    CommonText(text: "/"),
                    Expanded(child: CommonTextFormField(controller: bPDiastolicTextController,transparent: true,keyboardType: TextInputType.number)),
                    Container(
                        padding: EdgeInsets.only(right: 5),
                        child: CommonText(text: "mmHg")),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(child: getSingleVitalValue(title: "Blood group", textEditingController: bloodGroupTextController,isChar: true)),
          ],
        ),
        const SizedBox(height: 10,),
      ],
    );
  }

  Widget getSingleVitalValue({required String title,required TextEditingController textEditingController,String? suffix , bool isChar=false}){
    return Row(
      children: [
        CommonText(text: title),
        const SizedBox(width: 5,),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor.withOpacity(.06),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: AppTheme.lightTheme.primaryColor)
            ),
            child: Row(
              children: [
                Expanded(child: CommonTextFormField(controller: textEditingController,transparent: true,keyboardType: isChar?TextInputType.text:TextInputType.number,)),
                VerticalDivider(color: Colors.black,width: 5,),
                suffix!=null?Container(
                    padding: EdgeInsets.only(right: 5),
                    child: CommonText(text: suffix)):SizedBox.shrink(),
              ],
            ),
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
                List list = await showModalBottomSheet(
                  isDismissible: false,
                    isScrollControlled: true,
                    enableDrag: true,
                    context: context,
                    builder: (context){
                      return Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: const GetMedicineDialog(),
                      );
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
                price = ParsingHelper.parseDoubleMethod(billTextController.text);
                discount  = (discountTextController.text.isNotEmpty?ParsingHelper.parseDoubleMethod(discountTextController.text):0);
                total = double.parse(billTextController.text)-discount;
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
    return Column(
      children: [
        getBillRows(title:AppStrings.consultancyFee,amount: price.toString()),
        const SizedBox(height: 10,),
        getBillRows(title:AppStrings.discountPrice,amount: "-$discount"),
        const SizedBox(height: 10,),
        const Divider(),
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

  Widget getEndVisitButton(){
    return FxButton.small(
      block: true,
      borderRadiusAll: 4,
      buttonType: FxButtonType.outlined,
      splashColor: themeData.colorScheme.primary.withAlpha(60),
      borderColor: themeData.primaryColor,
      onPressed: () async{
        setState((){
          isLoading=true;
        });

        await uploadVisit();

        setState((){
          isLoading=false;
        });
      },
      elevation: 0,
      child: FxText.bodyMedium(
      AppStrings.endVisit,
      color: themeData.primaryColor,
      ),
    );
  }
}


