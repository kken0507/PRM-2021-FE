import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/landing.dart';
import 'package:kiennt_restaurant/models/login_user.dart';

import 'package:kiennt_restaurant/models/api_err.dart';
import 'package:kiennt_restaurant/models/api_response.dart';

import 'package:kiennt_restaurant/services/auth.dart';

//widgets
import 'package:kiennt_restaurant/widgets/input.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

  static String routeName = "/login";
}

class _LoginState extends State<Login> {
  final double height = window.physicalSize.height;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  LoginUser user = new LoginUser(email: "", password: "");
  ApiResponse _apiResponse = new ApiResponse();

  void showInSnackBar(String msg) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'DONE',
          onPressed: () {},
        )));
  }

  void _redirectToHome() async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Landing.routeName,
      ModalRoute.withName(Landing.routeName),
    );
  }

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      _apiResponse = await authenticateUser(user.email, user.password);
      if ((_apiResponse.ApiError as ApiError) == null) {
        _redirectToHome();
      } else {
        showInSnackBar((_apiResponse.ApiError as ApiError).message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/orange-bg.jpg"),
                      fit: BoxFit.cover)),
            ),
            SafeArea(
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 24.0, right: 24.0, bottom: 32),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.63,
                              color: Color.fromRGBO(244, 245, 247, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 23.0, bottom: 23.0),
                                        child: Center(
                                          child: Text("Login with email",
                                              style: TextStyle(
                                                  color: ThemeColors.text,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 32)),
                                        ),
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Input(
                                                  placeholder: "Email",
                                                  controller:
                                                      TextEditingController(
                                                          text: user.email),
                                                  onChanged: (val) {
                                                    user.email = val;
                                                  },
                                                  prefixIcon:
                                                      Icon(Icons.email)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Input(
                                                  placeholder: "Password",
                                                  controller:
                                                      TextEditingController(
                                                          text: user.password),
                                                  onChanged: (val) {
                                                    user.password = val;
                                                  },
                                                  prefixIcon: Icon(Icons.lock)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16),
                                              child: Center(
                                                child: FlatButton(
                                                  textColor: ThemeColors.white,
                                                  color: ThemeColors.primary,
                                                  onPressed: () {
                                                    // Respond to button press
                                                    // Navigator.pushNamed(
                                                    //     context, '/home');
                                                    _handleSubmitted();
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 16.0,
                                                          right: 16.0,
                                                          top: 12,
                                                          bottom: 12),
                                                      child: Text("Login",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16.0))),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )),
                ),
              ]),
            )
          ],
        ));
  }
}
