import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';

class CardSession extends StatelessWidget {
  CardSession(
      {this.cta = "Press to see more...",
      this.orderQuantity = 0,
      this.sessionNum = "Session#000",
      this.position = "000",
      this.onTap = defaultFunc});

  final Function onTap;
  final int orderQuantity;
  final String cta;
  final String sessionNum;
  final String position;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 0.6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Session#" + sessionNum + " - position: " + position,
                      style:
                          TextStyle(color: ThemeColors.header, fontSize: 13)),
                  Text("Pending order(s): " + orderQuantity.toString(),
                      style:
                          TextStyle(color: ThemeColors.header, fontSize: 11)),
                  Text(cta,
                      style: TextStyle(
                          color: ThemeColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
        ));
  }
}
