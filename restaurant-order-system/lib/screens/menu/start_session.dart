import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/configs/size_config.dart';

import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/screens/menu/menu.dart';
import 'package:kiennt_restaurant/util/dialog_util.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';

//widgets
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:kiennt_restaurant/widgets/drawer.dart';

class StartSessionScreen extends StatelessWidget {
  static String routeName = "/start-session";
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Start session",
        ),
        backgroundColor: ThemeColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: ArgonDrawer(currentPage: "Menu"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // // DefaultButton(color: ThemeColors.info, press: () async {
              // //     var isSuccess = await MyApi().openSession();
              // //     if (isSuccess) {
              // //       await Navigator.pushReplacementNamed(
              // //           context, MenuScreen.routeName);
              // //     } else {
              // //       DialogUtil().errorDialog(
              // //           context, () {}, "ERROR", "Open new session failed");
              // //     }
              // //   }, text: "Start",)

              // Text("Press to start new session"),
              // ElevatedButton(
              //   onPressed: () async {
              //     var isSuccess = await MyApi().openSession();
              //     if (isSuccess) {
              //       await Navigator.pushReplacementNamed(
              //           context, MenuScreen.routeName);
              //     } else {
              //       DialogUtil().errorDialog(
              //           context, () {}, "ERROR", "Open new session failed");
              //     }
              //   },
              //   child: Text("Start"),
              // ),
              Expanded(child: _card(context)),
            ],
          ),
        ));
  }
}

Widget _card(context) {
  SizeConfig().init(context);
  return Card(
    elevation: 0.6,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6.0))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Press to start new session',
          style: TextStyle(fontSize: 25),
        ),
        Center(
          child: SizedBox(
            width: getProportionateScreenWidth(190.0),
            child: DefaultButton(
              color: ThemeColors.info,
              press: () async {
                var isSuccess = await MyApi().openSession();
                if (isSuccess) {
                  await Navigator.pushReplacementNamed(
                      context, MenuScreen.routeName);
                } else {
                  DialogUtil().errorDialog(
                      context, () {}, "ERROR", "Open new session failed");
                }
              },
              text: "Start",
            ),
          ),
        ),
      ],
    ),
  );
}
