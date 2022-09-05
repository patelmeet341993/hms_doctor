import 'package:doctor/views/common/components/common_button.dart';
import 'package:doctor/views/diagnosis/screens/diagnosis_form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../packages/flux/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import '../patients/screens/patient_list.dart';
import '../profile/screens/profile_page.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late ThemeData themeData;


  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FxBottomNavigationBar(
        containerDecoration: BoxDecoration(
          color: themeData.colorScheme.background,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        activeContainerColor: themeData.colorScheme.primary.withOpacity(.2),
        fxBottomNavigationBarType: FxBottomNavigationBarType.containered,
        showActiveLabel: false,
        showLabel: false,
        activeIconSize: 20,
        iconSize: 20,
        activeIconColor:  themeData.colorScheme.primary,
        iconColor: themeData.colorScheme.onBackground,
        itemList: [
          FxBottomNavigationBarItem(
            page: const PatientList(),
            activeIconData: FontAwesomeIcons.list,
            iconData: FontAwesomeIcons.list,
            //activeIcon: Icon(FontAwesomeIcons.list,size: 15,color: themeData.colorScheme.primary)

          ),
          FxBottomNavigationBarItem(
            page: const DiagnosisForm(),
            activeIconData: FontAwesomeIcons.stethoscope,
            iconData: FontAwesomeIcons.stethoscope,


          ),
          FxBottomNavigationBarItem(
            page: const ProfileScreen(),
            activeIconData: FontAwesomeIcons.idBadge,
            iconData: FontAwesomeIcons.idBadge,

          ),
        ],
      ),
    );
  }
}
