import 'package:flutter/material.dart';
import 'package:hms_models/hms_models.dart';

import '../controllers/authentication_controller.dart';
import '../controllers/navigation_controller.dart';
import 'authentication/login_screen.dart';
import 'homescreen/homescreen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/SplashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ThemeData themeData;

  Future<void> checkLogin() async {
    // await Future.delayed(Duration(seconds: 2));

    AdminUserModel? user = await AuthenticationController().isUserLoggedIn();
    MyPrint.printOnConsole("User From isUserLoggedIn:$user");

    NavigationController.isFirst = false;
    if(user != null) {
      Navigator.pushNamedAndRemoveUntil(NavigationController.mainScreenNavigator.currentContext!, HomeScreen.routeName, (route) => false);
    }
    else {
      Navigator.pushNamedAndRemoveUntil(NavigationController.mainScreenNavigator.currentContext!, LoginScreen.routeName, (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.inkDrop(color: themeData.primaryColor, size: 40),
      ),
    );
  }
}
