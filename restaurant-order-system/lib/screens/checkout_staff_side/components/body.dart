import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/common/order_detail.dart';
import 'package:kiennt_restaurant/models/common/session.dart';
import 'package:kiennt_restaurant/models/response/bill.dart';

class Body extends StatelessWidget {
  // Declare a field that holds the Item.
  final BillResponse bill;
  // Declare a field that holds the Item.
  final Function ontap;

  // In the constructor, a Item, function onTap.
  Body({Key key, this.ontap, this.bill}) : super(key: key);

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
                            bill.session.sessionNumber +
                            " - pos:" +
                            bill.session.position,
                        style:
                            TextStyle(color: ThemeColors.header, fontSize: 18)),
                  )),
            )),
        Flexible(
          flex: 3,
          child: CardOrderDetail(
            session: bill.session,
          ),
        ),
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
                        "Total items: " +
                            bill.totalItemQuantity.toString() + "- Total price: " + bill.totalPrice.toString(),
                        style:
                            TextStyle(color: ThemeColors.header, fontSize: 16)),
                  )),
            )
        ),
      ],
    );
  }
}

class CardOrderDetail extends StatelessWidget {
  CardOrderDetail({this.session = null, this.onTap = defaultFunc});

  final Function onTap;
  final Session session;

  static void defaultFunc() {
    print("the function works!");
  }

  int _detailCount() {
    int res = 0;
    for (var order in session.orders) {
      for (var detail in order.orderDetails) {
        res += detail.quantity;
      }
    }
    return res;
  }

  List<OrderDetail> _allOrderDetails() {
    List<OrderDetail> res =[];
    for (var order in session.orders) {
      for (var detail in order.orderDetails) {
        res.add(detail);
      }
    }
    return res;
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
                itemCount: _allOrderDetails().length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Text(
                      '${index + 1} - ${_allOrderDetails()[index].item.name} X ${_allOrderDetails()[index].quantity}',
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
