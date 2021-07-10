import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/common/session.dart';
import 'package:kiennt_restaurant/screens/checkout/after_checkout.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/services/storage/local_storage.dart';
import 'package:kiennt_restaurant/util/dialog_util.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';

import 'package:kiennt_restaurant/configs/size_config.dart';

class Bottom extends StatelessWidget {
  const Bottom({
    Key key,
    this.session,
  }) : super(key: key);

  final Session session;

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
            SizedBox(
                  // width: getProportionateScreenWidth(150.0),
                  child: DefaultButton(
                    text: "Checkout",
                    color: ThemeColors.initial,
                    press: () async {
                      if (session != null) {
                        DialogUtil().confirmDialog(context, () async {
                          var isSuccess =
                              await MyApi().closeSession(session.sessionId);
                          if (isSuccess) {
                            LocalStorage.deleteSesion();
                            Navigator.pushNamed(context, AfterCheckoutScreen.routeName, arguments: session);
                          } else {
                            await DialogUtil().errorDialog(context, () {},
                                "ERROR", "Failed to close session");
                          }
                        }, "Checkout?", "Do you want to checkout?");
                      }
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
