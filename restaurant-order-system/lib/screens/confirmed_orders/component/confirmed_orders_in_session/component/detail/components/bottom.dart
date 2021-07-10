import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/response/order.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/util/dialog_util.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';

import 'package:kiennt_restaurant/configs/size_config.dart';

class Bottom extends StatelessWidget {
  const Bottom({
    Key key,
    this.order,
  }) : super(key: key);

  final OrderResponse order;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    var _reasonController = TextEditingController();

    void _handleSubmitted(context) async {
      String reason = _reasonController.text;
      if (reason.trim() == "" || reason == null) {
        await DialogUtil().errorDialog(
            context, () {}, "ERROR", "Invalid reason, please re-input");
      } else {
        var isSuccess = await MyApi().dropOrder(order.orderId, reason);

        if (isSuccess) {
          await DialogUtil().successDialog(context, () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          }, "SUCCESS", "Order dropped successfuly");
        } else {
          await DialogUtil()
              .errorDialog(context, () {}, "ERROR", "Order dropped fail");
        }
      }
    }

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
                    text: "Serve",
                    color: ThemeColors.success,
                    press: () async {
                      if (order != null) {
                        DialogUtil().confirmDialog(context, () async {
                          var isSuccess =
                              await MyApi().serveOrder(order.orderId);
                          if (isSuccess) {
                            await DialogUtil().successDialog(context, () {
                              Navigator.pop(context);
                            }, "SUCCESS", "Order served successfuly");
                          } else {
                            await DialogUtil().errorDialog(context, () {},
                                "ERROR", "Order served fail");
                          }
                        }, "Serve?", "Do you want to serve this order?");
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(150.0),
                  child: DefaultButton(
                    text: "Drop",
                    color: ThemeColors.error,
                    press: () async {
                      if (order != null) {
                        // DialogUtil().confirmDialog(context, () async {
                        //   var isSuccess =
                        //       await MyApi().declineOrder(order.orderId);
                        //   if (isSuccess) {
                        //     await DialogUtil().successDialog(context, () {Navigator.pop(context);},
                        //         "SUCCESS", "Order declined successfuly");
                        //   } else {
                        //     await DialogUtil().errorDialog(context, () {},
                        //         "ERROR", "Order declined fail");
                        //   }
                        // }, "Confirm", "Do you want to declined this order?");
                        DialogUtil().oneInputFieldDialog(
                            context,
                            () => _handleSubmitted(context),
                            "Drop?",
                            "Reason",
                            _reasonController);
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
