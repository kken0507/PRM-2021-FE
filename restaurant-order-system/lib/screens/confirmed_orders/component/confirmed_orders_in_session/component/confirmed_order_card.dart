import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/response/order.dart';

class CardConfirmedOrder extends StatelessWidget {
  CardConfirmedOrder(
      {this.order = null,
      this.cta = "Press to see more...",
      this.index,
      this.onTap = defaultFunc});

  final Function onTap;
  String cta;
  OrderResponse order;
  int index;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
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
                          Text("Order Id: " + order.orderId.toString(),
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 13)),
                          Text(
                              "Ordered at: " +
                                  order.createdAt.toString().substring(0, 16),
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 13)),
                          Text("Items:",
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 13)),
                          if (order.orderDetails.length > 3)
                            for (var i = 0; i < 3; i++)
                              Text(
                                  i != 2
                                      ? order.orderDetails[i].item.name +
                                          "X" +
                                          order.orderDetails[i].quantity
                                              .toString()
                                      : "...",
                                  style: TextStyle(
                                      color: ThemeColors.header, fontSize: 11))
                          else
                            Expanded(
                                child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: order.orderDetails.length,
                              itemBuilder: (context, index) {
                                return Text(
                                    order.orderDetails[index].item.name +
                                        "X" +
                                        order.orderDetails[index].quantity
                                            .toString(),
                                    style: TextStyle(
                                        color: ThemeColors.header,
                                        fontSize: 11));
                              },
                            )),
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
