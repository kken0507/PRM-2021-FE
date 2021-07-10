import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/models/response/order.dart';

class Body extends StatelessWidget {
  // Declare a field that holds the Item.
  final OrderResponse order;
  // Declare a field that holds the Item.
  final Function ontap;

  // In the constructor, a Item, function onTap.
  Body({Key key, this.order, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: CardOrderDetail(
            order: order,
          ),
        ),
        Expanded(
          child: CardOrderStatus(
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

class CardOrderStatus extends StatelessWidget {
  CardOrderStatus(
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
            'STATUS',
            style: TextStyle(fontSize: 25),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: order.orderStatus.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Text(
                      '${index + 1} - ${order.orderStatus[index].status} ${(order.orderStatus[index].content != null) ? "-" : ""} ${order.orderStatus[index].content ?? ""} ${(order.orderStatus[index].createdAt != null) ? "-" : ""} ${order.orderStatus[index].createdAt.toString().substring(0, 19) ?? ""}',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
