import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/shopping_cart.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/util/dialog_util.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';

import 'package:kiennt_restaurant/configs/size_config.dart';

import 'package:provider/provider.dart';

import 'package:awesome_dialog/awesome_dialog.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key key,
  }) : super(key: key);

  _confirmDialog(context, btnOkOnPress) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO_REVERSED,
      borderSide: BorderSide(color: ThemeColors.info, width: 2),
      width: 500,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(6)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'INFO',
      desc: 'Dialog description here...',
      // showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: btnOkOnPress,
      dismissOnTouchOutside: true,
    )..show();
  }

  _sucessDialog(context, btnOkOnPress) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      borderSide: BorderSide(color: Colors.green, width: 2),
      width: 500,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(6)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'SUCCESS',
      desc: 'Dialog description here...',
      showCloseIcon: true,
      // btnCancelOnPress: () {},
      btnOkOnPress: btnOkOnPress,
      btnOkIcon: Icons.check_circle,
      dismissOnTouchOutside: true,
      autoHide: Duration(seconds: 3),
    )..show();
  }

  _errorDialog(context, btnOkOnPress) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      borderSide: BorderSide(color: Colors.red[900], width: 2),
      width: 500,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(6)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'ERROR',
      desc: 'Dialog description here...',
      showCloseIcon: true,
      // btnCancelOnPress: () {},
      btnOkOnPress: btnOkOnPress,
      btnOkColor: Colors.red[900],
      btnOkText: "Close",
      btnOkIcon: Icons.cancel,
      dismissOnTouchOutside: true,
      autoHide: Duration(seconds: 3),
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    var shoppingCart = Provider.of<ShoppingCart>(context);
    // double totalPrice = context.watch<ShoppingCart>().totalPrice;
    double totalPrice = shoppingCart.totalPrice;

    SizeConfig().init(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15.0),
        horizontal: getProportionateScreenWidth(30.0),
      ),
      // height: 174,
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
            // Row(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.all(10),
            //       height: getProportionateScreenWidth(40.0),
            //       width: getProportionateScreenWidth(40.0),
            //       decoration: BoxDecoration(
            //         color: Color(0xFFF5F6F9),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: SvgPicture.asset("assets/icons/receipt.svg"),
            //     ),
            //     Spacer(),
            //     Text("Add voucher code"),
            //     const SizedBox(width: 10),
            //     Icon(
            //       Icons.arrow_forward_ios,
            //       size: 12,
            //       color: kTextColor,
            //     )
            //   ],
            // ),
            // SizedBox(height: getProportionateScreenHeight(20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\VND " + totalPrice.toString(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190.0),
                  child: DefaultButton(
                    text: "Order",
                    color: ThemeColors.primary,
                    press: () async {
                      if (shoppingCart.items.length > 0) {
                        DialogUtil().confirmDialog(context, () async {
                          var isSuccess = await MyApi().createOrder(shoppingCart);
                          await shoppingCart.deleteAll();
                          if (isSuccess) {
                            await DialogUtil().successDialog(context, () {}, "SUCCESS", "Ordered successfuly");
                          } else {
                            await DialogUtil().errorDialog(context, () {}, "ERROR", "Order failed");
                          }
                        }, "Confirm", "Do you want to make this order?");
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
