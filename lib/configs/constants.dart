//App Version
import 'package:hms_models/hms_models.dart';

import '../views/common/models/home_screen_component_model.dart';
import '../views/diagnosis/screens/diagnosis_form.dart';
import '../views/patients/screens/patient_list.dart';
import '../views/profile/screens/profile_page.dart';
import 'app_strings.dart';

const String app_version = "1.0.0";

//Shared Preference Keys
class SharePrefrenceKeys {
  static const String appThemeMode = "themeMode";
  static const String loggedInUser = "loggedInUser";
}

class AppConstants {
  static const List<String> userTypesForLogin = [AdminUserType.doctor];

  static String hospitalId = "Hospital_1";
}

class HomeScreenComponentsList {
  final List<HomeScreenComponentModel> _masterOptions = [
    const HomeScreenComponentModel(icon: FontAwesomeIcons.list, activeIcon: FontAwesomeIcons.list, screen: PatientList(title: AppStrings.patients), title: AppStrings.patients),
    const HomeScreenComponentModel(icon: FontAwesomeIcons.stethoscope, activeIcon: FontAwesomeIcons.stethoscope, screen: DiagnosisForm(title: AppStrings.diagnosis), title: AppStrings.diagnosis),
    const HomeScreenComponentModel(icon: FontAwesomeIcons.user, activeIcon: FontAwesomeIcons.user, screen: ProfileScreen(title: AppStrings.profile), title: AppStrings.profile),
  ];

  List<HomeScreenComponentModel> getHomeScreenComponentsRolewise(String role) {
    return _masterOptions;
  }
}
