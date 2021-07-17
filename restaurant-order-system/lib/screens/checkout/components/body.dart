import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/response/bill.dart';

class Body extends StatelessWidget {
  // Declare a field that holds the Item.
  final BillResponse bill;
  // Declare a field that holds the Item.
  final Function ontap;

  final Function onRefresh;

  // In the constructor, a Item, function onTap.
  Body({Key key, this.ontap, this.bill, this.onRefresh = defaultFunc }) : super(key: key);

  static Future defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100.0,
                    alignment: Alignment.center,
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
                                style: TextStyle(
                                    color: ThemeColors.header, fontSize: 18)),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CardOrderDetail(
                      bill: bill,
                    ),
                  ),
                  Expanded(
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
                                    bill.totalItemQuantity.toString() +
                                    "- Total price: " +
                                    bill.totalPrice.toString(),
                                style: TextStyle(
                                    color: ThemeColors.header, fontSize: 16)),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: <Widget>[
    //     Flexible(
    //         fit: FlexFit.loose,
    //         flex: 1,
    //         child: Card(
    //           elevation: 0.6,
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(6.0))),
    //           child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Center(
    //                 child: Text(
    //                     "Session #" +
    //                         bill.session.sessionNumber +
    //                         " - pos:" +
    //                         bill.session.position,
    //                     style:
    //                         TextStyle(color: ThemeColors.header, fontSize: 18)),
    //               )),
    //         )),
    //     Flexible(
    //       fit: FlexFit.loose,
    //       flex: 3,
    //       child: CardOrderDetail(
    //         bill: bill,
    //       ),
    //     ),
    //     Flexible(
    //         fit: FlexFit.loose,
    //         flex: 1,
    //         child: Card(
    //           elevation: 0.6,
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(6.0))),
    //           child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Center(
    //                 child: Text(
    //                     "Total items: " +
    //                         bill.totalItemQuantity.toString() +
    //                         "- Total price: " +
    //                         bill.totalPrice.toString(),
    //                     style:
    //                         TextStyle(color: ThemeColors.header, fontSize: 16)),
    //               )),
    //         )),
    //   ],
    // );
  }
}

class CardOrderDetail extends StatelessWidget {
  CardOrderDetail({this.bill = null, this.onTap = defaultFunc});

  final Function onTap;
  final BillResponse bill;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.6,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'ITEMS',
              style: TextStyle(fontSize: 25),
            ),
            Container(
              width: double.maxFinite,
              height: 250,
              child: ListView.builder(
                shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: bill.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                        '${index + 1} - ${bill.items[index].item.name} X ${bill.items[index].quantity} = ${bill.items[index].price}',
                        style: TextStyle(fontSize: 21),
                      );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
