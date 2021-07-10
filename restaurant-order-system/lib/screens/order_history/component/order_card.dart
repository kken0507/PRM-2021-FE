import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';

class CardOrder extends StatelessWidget {
  CardOrder(
      {this.id = 0,
      this.index = 0,
      this.cta = "Press to see more...",
      this.status = "Status here",
      this.orderedAt = null,
      this.onTap = defaultFunc});

  final Function onTap;
  final int index;
  final int id;
  final String cta;
  final String status;
  final DateTime orderedAt;

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
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6.0),
                            bottomLeft: Radius.circular(6.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(index.toString()),
                      )),
                ),
                Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Order ID: " + id.toString(),
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 13)),
                          Text("Ordered at: " + orderedAt.toString(),
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 11)),
                          Text("Current status: " + status,
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 11)),
                          Text(cta,
                              style: TextStyle(
                                  color: ThemeColors.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
