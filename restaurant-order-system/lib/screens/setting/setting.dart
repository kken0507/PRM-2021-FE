import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/configs/size_config.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/screens/setting/setting_form.dart';
import 'package:kiennt_restaurant/services/storage/local_storage.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:kiennt_restaurant/widgets/stateful_warpper.dart';

class SettingScreen extends StatelessWidget {
  static String routeName = "/setting";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      body: body(),
      bottomNavigationBar: bottom(),
    );
  }

  Future _getThingsOnStartup() async {
    String position = await LocalStorage.getPositionFromStorage();
    if (position != null && position.trim().isNotEmpty) {
      _positionController.text = position;
    }
  }

  void showInSnackBar(String msg) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'DONE',
          onPressed: () {},
        )));
  }

  void _handleSubmitted() async {
    String text = _positionController.text.trim();
    if (await LocalStorage.getSessionFromStorage() != null) {
      showInSnackBar('Position can\'t changed because session is opening');
    } else {
      Pattern pattern =
          r"\s+";
      RegExp regex = new RegExp(pattern);
      if (text.trim().isEmpty) {
        showInSnackBar('Position can\'t be empty');
      } else if (text.contains(regex)) {
        showInSnackBar('Position can\'t contain whitespaces');
      } else {
        showInSnackBar('Saved');
        LocalStorage.savePosition(text);
      }
    }
  }

  body() {
    return StatefulWrapper(
      onInit: () {
        _getThingsOnStartup();
      },
      child: SettingForm(
        controller: _positionController,
        hintText: "Enter position",
      ),
    );
  }

  bottom() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15.0),
        horizontal: getProportionateScreenWidth(30.0),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: getProportionateScreenWidth(190.0),
                child: DefaultButton(
                  color: ThemeColors.primary,
                  text: "Save",
                  press: () {
                    _handleSubmitted();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Navbar(
      title: "Setting",
      backButton: true,
      rightOptionCart: false,
    );
  }
}
