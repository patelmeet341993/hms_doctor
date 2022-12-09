import 'package:doctor/configs/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hms_models/hms_models.dart';

import '../../../packages/flux/widgets/button/button.dart';
import '../../../packages/flux/widgets/text/text.dart';
import '../../common/components/common_text.dart';
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
  TextEditingController totalDaysTextController = TextEditingController();
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
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(AppStrings.medicine,style: themeData.textTheme.headline5?.apply(color: themeData.primaryColor),),
                  Container(),
                ],
              ),
              getMedicineType(),
              getMedicineName(),
              const SizedBox(height: 10,),
              getMedicineInstruction(),
              getMedicineTimings(),
              medicineType==MedicineType.other?const SizedBox.shrink():getTimingsDosageWidget(),
              getLastButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getMedicineType(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(AppStrings.medicineType,style: themeData.textTheme.headline6,),
        Radio<String>(
          value: MedicineType.tablet,
          groupValue: medicineType,
          onChanged: (value){
            setState(() {
              medicineType = value!;
            });
            MyPrint.printOnConsole("Value changed , $medicineType");
          },
        ),
        CommonText(text:MedicineType.tablet),
        Radio<String>(
          value: MedicineType.syrup,
          groupValue: medicineType,
          onChanged: (value){
            setState(() {
              medicineType = value!;
            });
            MyPrint.printOnConsole("Value changed , $medicineType");

          },
        ),
        CommonText(text:MedicineType.syrup),
        Radio<String>(
          value: MedicineType.other,
          groupValue: medicineType,
          onChanged: (value){
            setState(() {
              medicineType = value!;
            });
            MyPrint.printOnConsole("Value changed , $medicineType");
          },
        ),
        CommonText(text:MedicineType.other),
      ],
    );
  }

  Widget getMedicineName(){
    return Column(
      children: [
        Row(
          children: [
            Text(AppStrings.name,style: themeData.textTheme.headline6,),
            const SizedBox(width: 5,),
            Expanded(
              child: CommonTextFormField(
                controller: medicineNameTextController,
                hintText: AppStrings.enterMedicineName,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.enterMedicineName;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Text(AppStrings.quantity,style: themeData.textTheme.headline6,),
            const SizedBox(width: 5,),
            Expanded(
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
            const SizedBox(width: 10,),
            Text(AppStrings.totalDays,style: themeData.textTheme.headline6,),
            const SizedBox(width: 5,),
            Expanded(
              child: CommonTextFormField(
                controller: totalDaysTextController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.enterMedicineName;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getMedicineInstruction(){
    return Row(
      children: [
        Text(AppStrings.instructions,style: themeData.textTheme.headline6,),
        const SizedBox(width: 5,),
        Expanded(child: CommonTextFormField(controller: medicineInstructionTextController,hintText: AppStrings.enterExtraInstructions,)),
      ],
    );
  }

  Widget getMedicineTimings(){
    return Row(
      children: [
        Text(AppStrings.time,style: themeData.textTheme.headline6,),
        const SizedBox(width: 10,),
        Expanded(
          child: ToggleButtons(
            constraints: const BoxConstraints(
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
              MyPrint.printOnConsole("status = ${timingsBool[index]}, timinglist: ${advanceDoseModels.length}");
              for (AdvanceDoseModel element in advanceDoseModels) {
                MyPrint.printOnConsole("strings: ${element.title}");
              }
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
          child: const Text(AppStrings.advance,style: TextStyle(
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(AppStrings.beforeMeal,style: themeData.textTheme.bodySmall,),
                SizedBox(
                  height:25,
                  child: Checkbox(
                    value: advanceDoseModels[index].beforeMeal,
                    onChanged: (bool? value) {
                      setState(() {
                        advanceDoseModels[index].beforeMeal = value??false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(AppStrings.afterMeal,style: themeData.textTheme.bodySmall,),
                SizedBox(
                   height:25,
                   child: Checkbox(
                     value: advanceDoseModels[index].afterMeal,
                     onChanged: (bool? value) {
                       setState(() {
                         advanceDoseModels[index].afterMeal = value??false;
                       });
                     },
                   ),
                 ),
               ],
             ),
          ]
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(medicineType==MedicineType.syrup?AppStrings.dosageMl:AppStrings.dosage,style: themeData.textTheme.bodyLarge,),
              const SizedBox(width: 5,),
              Expanded(
                child: CommonTextFormField(
                  controller: advanceDoseModels[index].textEditingController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
    MyPrint.printOnConsole("in single widget length: ${advanceDoseModels.length}");
    return Column(
      children: List.generate(advanceDoseModels.length, (index) {
        MyPrint.printOnConsole("in single widget index: $index,title: ${advanceDoseModels[index].title}");
        return getSingleAdvancedWidget(index: index, title: advanceDoseModels[index].title);
      }),
    );
  }

  Widget getSingleAdvancedWidget({required int index,required String title}){
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: themeData.primaryColor,width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
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
        const SizedBox(width: 10,),
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
                MyPrint.printOnConsole("total dose string: ${prescriptionQuantityTextController.text + medicineType==MedicineType.syrup?" ml":""}");
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

