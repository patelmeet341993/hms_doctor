import 'package:doctor/configs/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:hms_models/utils/my_print.dart';
import 'package:hms_models/utils/my_safe_state.dart';
import 'package:hms_models/utils/my_toast.dart';

import '../../configs/app_theme.dart';
import '../../controllers/authentication_controller.dart';
import '../common/components/loading_widget.dart';
import '../common/components/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with MySafeState {
  late ThemeData themeData;
  bool isLoading = false;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login(String userName, String password) async {
    isLoading = true;
    mySetState();

    // await Future.delayed(const Duration(seconds: 3));
    bool isLoggedIn = await AuthenticationController().loginAdminUserWithUsernameAndPassword(context: context, userName: userName, password: password);
    MyPrint.printOnConsole("isLoggedIn:$isLoggedIn");

    isLoading = false;
    mySetState();

    if(!isLoggedIn) {
      MyToast.showError(context: context, msg: "Login Failed",);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    super.pageBuild();

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const LoadingWidget(),
      child: Scaffold(
        body: mainBody(),
      ),
    );
  }

  Widget mainBody(){
    return Form(
      key: _globalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MyRow(
            wrapAlignment: WrapAlignment.center,
            children: [
              MyCol(
                flex: const {
                  ScreenMediaType.SM: 16,
                  ScreenMediaType.MD: 12,
                  ScreenMediaType.XL: 10,
                  ScreenMediaType.XXL: 8,
                  ScreenMediaType.XXXL: 6,
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    MyContainer.rounded(
                      color: themeData.primaryColor.withOpacity(0.1),
                      child: Center(
                        child: Text("HMS",style: TextStyle(
                            color: themeData.primaryColor,
                            fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.w800
                        ),
                        ),
                      ),height: 100,width: 100,),

                    Spacing.height(24),
                    Text(
                      AppStrings.user_type_string_in_login_screen,
                      style: AppTheme.getTextStyle(
                          themeData.textTheme.headline6!,
                          color: themeData.colorScheme.onBackground,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5),
                    ),
                    Spacing.height(24),
                    MyContainer.bordered(
                      paddingAll:12,
                      // color: themeData.bgLayer2,
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: Spacing.all(6),
                            decoration: BoxDecoration(
                                color:
                                themeData.colorScheme.primary,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Icon(
                                Icons.email,
                                color: themeData.colorScheme.onPrimary,
                                size: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: Spacing.left(16),
                              child: TextFormField(
                                controller: usernameController,
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText1!,
                                    letterSpacing: 0.1,
                                    color: themeData
                                        .colorScheme.onBackground,
                                    fontWeight: FontWeight.w500),
                                validator: (String? text) {
                                  if(text?.isNotEmpty ?? false) {
                                    return null;
                                  }
                                  else {
                                    return "Username is Required";
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "UserName",
                                  hintStyle: AppTheme.getTextStyle(
                                      themeData.textTheme.subtitle2!,
                                      letterSpacing: 0.1,
                                      color: themeData
                                          .colorScheme.onBackground,
                                      fontWeight: FontWeight.w500),


                                  border: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      borderSide: BorderSide.none),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                      const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      borderSide: BorderSide.none),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      borderSide: BorderSide.none),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                ),
                                textCapitalization:
                                TextCapitalization.sentences,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacing.height(16),
                    MyContainer.bordered(
                      paddingAll:12,
                      // color: customAppTheme.bgLayer2,
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: Spacing.all(6),
                            decoration: BoxDecoration(
                                color:
                                themeData.colorScheme.primary,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Icon(
                                Icons.lock,
                                color:
                                themeData.colorScheme.onPrimary,
                                size: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: Spacing.left(16),
                              child: TextFormField(
                                controller: passwordController,
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText1!,
                                    letterSpacing: 0.1,
                                    color: themeData
                                        .colorScheme.onBackground,
                                    fontWeight: FontWeight.w500),
                                validator: (String? text) {
                                  if(text?.isNotEmpty ?? false) {
                                    return null;
                                  }
                                  else {
                                    return "Password is Required";
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: AppTheme.getTextStyle(
                                      themeData.textTheme.subtitle2!,
                                      letterSpacing: 0.1,
                                      color: themeData
                                          .colorScheme.onBackground,
                                      fontWeight: FontWeight.w500),

                                  border: const OutlineInputBorder(
                                      borderRadius:
                                      const BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacing.height(8),
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: InkWell(
                    //     onTap: () {
                    //       // Navigator.push(
                    //       //     context,
                    //       //     MaterialPageRoute(
                    //       //         builder: (context) =>
                    //       //             FoodPasswordScreen()));
                    //     },
                    //     child: Text(
                    //       "Forgot password",
                    //       style: AppTheme.getTextStyle(
                    //           themeData.textTheme.bodyText2!,
                    //           color: themeData
                    //               .colorScheme.onBackground,
                    //           letterSpacing: 0,
                    //           fontWeight: FontWeight.w500),
                    //     ),
                    //   ),
                    // ),
                    ElevatedButton(

                      onPressed: () {
                        if(_globalKey.currentState?.validate() ?? false) {
                          login(usernameController.text, passwordController.text);
                        }
                        // VisitController().createDummyVisitDataInFirestore();
                        // PatientController().createDummyPatientDataInFirestore();
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(Spacing.xy(32 , 0))
                      ),
                      child: Text(
                        "Login".toUpperCase(),
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.bodyText2!,
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onPrimary,
                            letterSpacing: 0.5),
                      ),
                    ),
                    Spacing.height(16),
                    // InkWell(
                    //   onTap: () {
                    //     // Navigator.push(
                    //     //     context,
                    //     //     MaterialPageRoute(
                    //     //         builder: (context) =>
                    //     //             FoodRegisterScreen()));
                    //   },
                    //   child: Text(
                    //     "I haven't an account",
                    //     style: AppTheme.getTextStyle(
                    //         themeData.textTheme.bodyText2!,
                    //         color: themeData.colorScheme.onBackground,
                    //         fontWeight: FontWeight.w500,
                    //         decoration: TextDecoration.underline),
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
