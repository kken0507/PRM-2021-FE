import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/common/session.dart';
import 'package:kiennt_restaurant/models/response/session.dart';
import 'package:kiennt_restaurant/screens/menu/dispatcher.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/util/dialog_util.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';

import 'package:kiennt_restaurant/configs/size_config.dart';

class BottomAfterCheckOut extends StatelessWidget {
  const BottomAfterCheckOut({
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
                    text: "Close",
                    color: ThemeColors.info,
                    press: () async {
                      if (session != null) {
                        DialogUtil().confirmDialog(context, () async {
                          SessionResponse curSession = await MyApi().getSessionById(session.sessionId);
                          if (curSession?.status == "COMPLETED") {
                            Navigator.pushReplacementNamed(context, MenuDispatcher.routeName);
                          } else {
                            await DialogUtil().errorDialog(context, () {},
                                "ERROR", "Failed to close");
                          }
                        }, "Close?", "Do you want to close?");
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
