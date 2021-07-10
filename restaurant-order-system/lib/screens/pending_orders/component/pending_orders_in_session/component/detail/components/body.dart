import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/response/order.dart';
import 'package:kiennt_restaurant/models/response/session.dart';

class Body extends StatelessWidget {
  // Declare a field that holds the Item.
  final OrderResponse order;
  // Declare a field that holds the Item.
  final Function ontap;

  final SessionResponse session;

  // In the constructor, a Item, function onTap.
  Body({Key key, this.order, this.ontap, this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
            flex: 1,
            child: Card(
              elevation: 0.6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        "Session #" +
                            session.sessionNumber +
                            " - pos:" +
                            session.position,
                        style:
                            TextStyle(color: ThemeColors.header, fontSize: 18)),
                  )),
            )),
        Flexible(
          flex: 3,
          child: CardOrderDetail(
            order: order,
          ),
        ),
      ],
    );
  }
}

class CardOrderDetail extends StatelessWidget {
  CardOrderDetail(
      {this.id = 0,
      this.index = 0,
      this.cta = "Press to see more...",
      this.status = "Status here",
      this.order = null,
      this.onTap = defaultFunc});

  final Function onTap;
  final int index;
  final int id;
  final String cta;
  final String status;
  final OrderResponse order;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.6,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      child: Column(
        children: [
          Text(
            'ITEMS',
            style: TextStyle(fontSize: 25),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: order.orderDetails.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Text(
                      '${index + 1} - ${order.orderDetails[index].item.name} X ${order.orderDetails[index].quantity}',
                      style: TextStyle(fontSize: 21),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}