import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/response/bill.dart';
import 'package:kiennt_restaurant/models/response/order.dart';
import 'package:kiennt_restaurant/screens/checkout_staff_side/checkout_staff_side.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/util/dialog_util.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';

import 'package:kiennt_restaurant/configs/size_config.dart';

class Bottom extends StatelessWidget {
  const Bottom({
    Key key,
    this.sessionNumber,
    this.onPress,
  }) : super(key: key);

  final String sessionNumber;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(150.0),
                  child: DefaultButton(
                    text: "Checkout",
                    color: ThemeColors.initial,
                    press: () async {
                      BillResponse bill = await MyApi().getBillBySessionNum(sessionNumber);
                      if (bill != null) {
                        DialogUtil().confirmDialog(context, () async {
                          var isSuccess =
                              await MyApi().completeSession(bill.session.sessionId);
                          if (isSuccess) {
                            await DialogUtil().successDialog(context, () {
                              Navigator.pushReplacementNamed(context, CheckoutStaffScreen.routeName);
                            }, "SUCCESS", "Checkout successfuly");
                          } else {
                            await DialogUtil().errorDialog(context, () {},
                                "ERROR", "Checkout failed");
                          }
                        }, "Checkout?", "Do you want to checkout?");
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(150.0),
                  child: DefaultButton(
                    text: "Scan QR",
                    color: ThemeColors.info,
                    press: onPress,
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
