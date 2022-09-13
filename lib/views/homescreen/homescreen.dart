import 'package:doctor/views/diagnosis/screens/diagnosis_form.dart';
import 'package:doctor/views/homescreen/components/custom_bottom_navigation_bar.dart';
import 'package:doctor/views/patients/screens/patient_list.dart';
import 'package:doctor/views/profile/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return mainBody();
  }

  Widget mainBody(){
    return CustomBottomNavigation(
      icons: const [
        FontAwesomeIcons.list,
        FontAwesomeIcons.stethoscope,
        FontAwesomeIcons.user
      ],
      activeIcons: const [
        FontAwesomeIcons.list,
        FontAwesomeIcons.stethoscope,
        FontAwesomeIcons.user
      ],
      screens: [
        PatientList(),
        DiagnosisForm(),
        ProfileScreen(),
      ],
      titles: const ["Patients", "Diagnosis", "Profile"],
      color: themeData.colorScheme.onBackground,
      activeColor: themeData.colorScheme.primary,
      navigationBackground: themeData.backgroundColor,
      brandTextColor: themeData.colorScheme.onBackground,
      initialIndex: 2,
      splashColor: themeData.splashColor,
      highlightColor: themeData.highlightColor,
      backButton: Container(),
      floatingActionButton: Container(),
      iconSize: 20,
      activeIconSize: 20,
      verticalDividerColor: themeData.dividerColor,
      bottomNavigationElevation: 8,
    );
  }
}
