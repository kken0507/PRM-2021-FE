import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';

class DialogUtil {
  void confirmDialog(context, btnOkOnPress, title, desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO_REVERSED,
      borderSide: BorderSide(color: ThemeColors.info, width: 2),
      width: 500,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(6)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: title ?? 'INFO',
      desc: desc ?? 'Dialog description here...',
      // showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: btnOkOnPress ?? () {},
      dismissOnTouchOutside: true,
    )..show();
  }

  void successDialog(context, btnOkOnPress, title, desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      borderSide: BorderSide(color: Colors.green, width: 2),
      width: 500,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(6)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: title ?? 'SUCCESS',
      desc: desc ?? 'Dialog description here...',
      showCloseIcon: false,
      // btnCancelOnPress: () {},
      btnOkOnPress: btnOkOnPress ?? () {},
      btnOkIcon: Icons.check_circle,
      dismissOnTouchOutside: false,
      // autoHide: Duration(seconds: 3),
    )..show();
  }

  void errorDialog(context, btnOkOnPress, title, desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      borderSide: BorderSide(color: Colors.red[900], width: 2),
      width: 500,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(6)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: title ?? 'ERROR',
      desc: desc ?? 'Dialog description here...',
      showCloseIcon: false,
      // btnCancelOnPress: () {},
      btnOkOnPress: btnOkOnPress ?? () {},
      btnOkColor: Colors.red[900],
      btnOkText: "Close",
      btnOkIcon: Icons.cancel,
      dismissOnTouchOutside: false,
      // autoHide: Duration(seconds: 3),
    )..show();
  }

  void oneInputFieldDialog(context, btnOkOnPress, title, label, textEditingController) {
    TextEditingController thisController;
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      keyboardAware: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              title ?? 'Form Data',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              elevation: 0,
              color: Colors.blueGrey.withAlpha(40),
              child: TextFormField(
                controller: textEditingController ?? thisController,
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLengthEnforced: true,
                minLines: 2,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: label ?? 'Label',
                  prefixIcon: Icon(Icons.text_fields),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: AnimatedButton(
                      color: ThemeColors.error,
                        isFixedHeight: false,
                        text: 'Cancel',
                        pressEvent: () {
                              dialog.dismiss();
                            })),
                Expanded(
                    child: AnimatedButton(
                      color: ThemeColors.success,
                        isFixedHeight: false,
                        text: 'Submit',
                        pressEvent: btnOkOnPress ??
                            () {
                              dialog.dismiss();
                            })),
              ],
            ),
          ],
        ),
      ),
    )..show();
  }
}
