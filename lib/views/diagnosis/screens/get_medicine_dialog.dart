import 'package:doctor/configs/app_strings.dart';
import 'package:doctor/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/visit_model/prescription/prescription_medicine_dose_model.dart';
import '../../../models/visit_model/prescription/prescription_model.dart';
import '../../../packages/flux/widgets/button/button.dart';
import '../../../packages/flux/widgets/text/text.dart';
import '../../../utils/logger_service.dart';
import '../../../utils/my_safe_state.dart';
import '../../common/components/common_text_form_field.dart';

class GetMedicineDialog extends StatefulWidget {
  const GetMedicineDialog({Key? key}) : super(key: key);

  @override
  State<GetMedicineDialog> createState() => _GetMedicineDialogState();
}

class _GetMedicineDialogState extends State<GetMedicineDialog> with MySafeState {

  late ThemeData themeData;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController medicineNameTextController = TextEditingController();
  TextEditingController medicineInstructionTextController = TextEditingController();
  TextEditingController prescriptionQuantityTextController = TextEditingController();

  bool isAdvanced=false;
  List<bool> timingsBool = [true, false, true];
  List<AdvanceDoseModel> advanceDoseModels=[];

  String medicineType = MedicineType.tablet;


  @override
  void initState() {
    advanceDoseModels.add(AdvanceDoseModel(title: PrescriptionMedicineDoseTime.morning));
    advanceDoseModels.add(AdvanceDoseModel(title: PrescriptionMedicineDoseTime.evening));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(AppStrings.medicine,style: themeData.textTheme.headline5?.apply(color: themeData.primaryColor),),
                    Container(),
                  ],
                ),
                Text(AppStrings.medicineType,style: themeData.textTheme.headline6,),
                getMedicineType(),
                getMedicineName(),
                SizedBox(height: 10,),
                getMedicineInstruction(),
                getMedicineTimings(),
                medicineType==MedicineType.other?SizedBox.shrink():getTimingsDosageWidget(),
                getLastButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getMedicineType(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: MedicineType.tablet,
          groupValue: medicineType,
          onChanged: (value){
            setState(() {
              medicineType = value!;
            });
            Log().d("Value changed , $medicineType");
          },
        ),
        Text(MedicineType.tablet),
        Radio<String>(
          value: MedicineType.syrup,
          groupValue: medicineType,
          onChanged: (value){
            setState(() {
              medicineType = value!;
            });
            Log().d("Value changed , $medicineType");

          },
        ),
        Text(MedicineType.syrup),
        Radio<String>(
          value: MedicineType.other,
          groupValue: medicineType,
          onChanged: (value){
            setState(() {
              medicineType = value!;
            });
            Log().d("Value changed , $medicineType");
          },
        ),
        Text(MedicineType.other),
      ],
    );
  }

  Widget getMedicineName(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Text(AppStrings.name,style: themeData.textTheme.headline6,),
              SizedBox(height: 5,),
              CommonTextFormField(
                controller: medicineNameTextController,
                hintText: AppStrings.enterMedicineName,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.enterMedicineName;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Text(medicineType==MedicineType.syrup?AppStrings.quantityInML:AppStrings.quantity,style: themeData.textTheme.headline6,),
              SizedBox(height: 5,),
              SizedBox(
                  width:50,
                  child: CommonTextFormField(
                    keyboardType: TextInputType.number,
                    controller: prescriptionQuantityTextController,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.enterQuantity;
                      }
                      return null;
                    },
                  ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getMedicineInstruction(){
    return Row(
      children: [
        Text(AppStrings.instructions,style: themeData.textTheme.headline6,),
        SizedBox(width: 5,),
        Expanded(child: CommonTextFormField(controller: medicineInstructionTextController,hintText: AppStrings.enterExtraInstructions,)),
      ],
    );
  }

  Widget getMedicineTimings(){
    return Row(
      children: [
        Text(AppStrings.time,style: themeData.textTheme.headline6,),
        SizedBox(width: 10,),
        Expanded(
          child: ToggleButtons(
            constraints: BoxConstraints(
                maxHeight: 70,
                minHeight: 30
            ),
            splashColor: themeData.colorScheme.primary.withAlpha(48),
            color: themeData.colorScheme.onBackground,
            fillColor: themeData.colorScheme.primary.withAlpha(48),
            selectedBorderColor: themeData.colorScheme.primary.withAlpha(48),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            isSelected: timingsBool,
            onPressed: (int index) {
              timingsBool[index] = !timingsBool[index];
              String title = index==0?PrescriptionMedicineDoseTime.morning:index==1?PrescriptionMedicineDoseTime.afternoon:PrescriptionMedicineDoseTime.evening;
              int value = advanceDoseModels.indexWhere((element) => element.title == title);
              if(timingsBool[index] && value == -1){
                advanceDoseModels.add(AdvanceDoseModel(title: title));
              }
              else if(advanceDoseModels.length>1){
                advanceDoseModels.removeWhere((element) => element.title==title);
              }
              Log().d("status = ${timingsBool[index]}, timinglist: ${advanceDoseModels.length}");
              advanceDoseModels.forEach((element) {
                Log().d("strings: ${element.title}");
              });
              mySetState();
            },
            children: <Widget>[
              toggleButtonText(PrescriptionMedicineDoseTime.morning),
              toggleButtonText(PrescriptionMedicineDoseTime.afternoon),
              toggleButtonText(PrescriptionMedicineDoseTime.evening),
            ],
          ),
        ),
      ],
    );
  }

  Widget toggleButtonText(String name){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 0),
      child: Text(name,style: themeData.textTheme.bodyMedium),
    );
  }

  Widget getTimingsDosageWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isAdvanced?getAdvancedWidget():getBMealAMealWidget(),
        InkWell(
          onTap: (){
            isAdvanced=!isAdvanced;
            mySetState();
          },
          child: Text(AppStrings.advance,style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue,
            fontSize: 14,
          ),),
        ),
      ],
    );
  }
  
  Widget getBMealAMealWidget({int index=0}){
    return Row(
      children: [
        Row(
          children:[
              Text(AppStrings.beforeMeal,style: themeData.textTheme.bodySmall,),
              SizedBox(
                width:35,
                height:35,
                child: Checkbox(
                  value: advanceDoseModels[index].beforeMeal,
                  onChanged: (bool? value) {
                    setState(() {
                      advanceDoseModels[index].beforeMeal = value??false;
                    });
                  },
                ),
              ),
              Text(AppStrings.afterMeal,style: themeData.textTheme.bodySmall,),
              SizedBox(
                width:35,
                height:35,
                child: Checkbox(
                  value: advanceDoseModels[index].afterMeal,
                  onChanged: (bool? value) {
                    setState(() {
                      advanceDoseModels[index].afterMeal = value??false;
                    });
                  },
                ),
              )
          ]
        ),
        Expanded(
          child: Row(
            children: [
              Text(AppStrings.dosage,style: themeData.textTheme.bodyLarge,),
              SizedBox(width: 5,),
              SizedBox(
                  height:40,
                  width:40,
                  child: CommonTextFormField(
                    controller: advanceDoseModels[index].textEditingController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.enterDosage;
                      }
                      return null;
                    },
                  ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getAdvancedWidget(){
    Log().d("in single widget length: ${advanceDoseModels.length}");
    return Column(
      children: List.generate(advanceDoseModels.length, (index) {
        Log().d("in single widget index: $index,title: ${advanceDoseModels[index].title}");
        return getSingleAdvancedWidget(index: index, title: advanceDoseModels[index].title);
      }),
    );
  }

  Widget getSingleAdvancedWidget({required int index,required String title}){
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: themeData.primaryColor,width: 1),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: themeData.primaryColor.withOpacity(.1)
      ),
      child: Column(
        children: [
          Text(title,style: themeData.textTheme.bodyMedium,),
          getBMealAMealWidget(index: index),
        ],
      ),

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
              if(_formKey.currentState!.validate()){
                List<PrescriptionMedicineDoseModel> prescriptionList=[];
                if(isAdvanced){
                  for (var element in advanceDoseModels) {
                    PrescriptionMedicineDoseModel prescriptionMedicineDoseModel = PrescriptionMedicineDoseModel(
                      afterMeal: element.afterMeal,
                      beforeMeal: element.beforeMeal,
                      dose: element.textEditingController.text + (medicineType==MedicineType.syrup?" ml":""),
                      doseTime: element.title
                    );
                    prescriptionList.add(prescriptionMedicineDoseModel);
                  }
                }
                else
                {
                  for (var element in advanceDoseModels){
                    PrescriptionMedicineDoseModel prescriptionMedicineDoseModel = PrescriptionMedicineDoseModel(
                        afterMeal: advanceDoseModels[0].afterMeal,
                        beforeMeal: advanceDoseModels[0].beforeMeal,
                        dose: advanceDoseModels[0].textEditingController.text,
                        doseTime: element.title
                    );
                    prescriptionList.add(prescriptionMedicineDoseModel);
                  }
                }
                PrescriptionModel prescriptionModel = PrescriptionModel(
                  medicineName: medicineNameTextController.text,
                  instructions: medicineInstructionTextController.text,
                  medicineType: medicineType,
                  totalDose: prescriptionQuantityTextController.text + (medicineType==MedicineType.syrup?" ml":""),
                  doses: prescriptionList,
                );
                Log().d("total dose string: ${prescriptionQuantityTextController.text + medicineType==MedicineType.syrup?" ml":""}");
                Navigator.pop(context,[true,prescriptionModel]);
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

class AdvanceDoseModel{
  TextEditingController textEditingController=TextEditingController();
  bool beforeMeal = false;
  bool afterMeal = true;
  String title;
  AdvanceDoseModel({required this.title});
}

