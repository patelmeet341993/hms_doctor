//App Version
import 'package:doctor/configs/app_strings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../views/common/models/home_screen_component_model.dart';
import '../views/diagnosis/screens/diagnosis_form.dart';
import '../views/patients/screens/patient_list.dart';
import '../views/profile/screens/profile_page.dart';

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

class PatientGender {
  static const String male = "Male";
  static const String female = "Female";
  static const String other = "Other";
}

class MedicineType {
  static const String tablet = "Tablet";
  static const String syrup = "Syrup";
  static const String other = "Other";
}

class AdminUserType {
  static const String admin = "Admin";
  static const String doctor = "Doctor";
  static const String pharmacy = "Pharmacy";
  static const String laboratory = "Laboratory";
  static const String reception = "Reception";
}

class FirebaseNodes {
  static const String adminUsersCollection = "admin_users";
  static const String patientCollection = "patient";
  static const String visitsCollection = "visits";
}

class PrescriptionMedicineDoseTime {
  static const String morning = "Morning";
  static const String afternoon = "Afternoon";
  static const String evening = "Evening";
  static const String night = "Night";
}

class PaymentModes {
  static const String cash = "Cash";
  static const String upi = "UPI";
  static const String creditCard = "Credit Card";
  static const String debitCard = "Debit Card";
}

class PaymentStatus {
  static const String pending = "Pending";
  static const String paid = "Paid";

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

//url
const String noUserImageUrl = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";