import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/response/bill.dart';
import 'package:kiennt_restaurant/screens/checkout/components/body.dart';
import 'package:kiennt_restaurant/screens/checkout/components/bottom_after_checkout.dart';
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AfterCheckoutScreen extends StatelessWidget {
  static String routeName = "/after-checkout";

  const AfterCheckoutScreen({Key key}) : super(key: key);

  Widget _body(bill) {
    // Session session = ModalRoute.of(context).settings.arguments;

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
            child: Card(
              elevation: 0.6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: QrImage(
                    data: bill.session.sessionNumber,
                    size: 200,
                  ),
                ),
              ),
            )),
            Flexible(
          flex: 3,
          child: CardOrderDetail(
            bill: bill,
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

  @override
  Widget build(BuildContext context) {

    BillResponse bill = ModalRoute.of(context).settings.arguments;

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: Navbar(
          title: "Please call a staff...",
          // backButton: true,
          rightOptionCart: false,
        ),
        body: _body(bill),
        bottomNavigationBar: BottomAfterCheckOut(session: bill.session,),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: Navbar(
  //         title: "Please call a staff...",
  //         // backButton: true,
  //         rightOptionCart: false,
  //       ),
  //       body: _body(context),
  //     );
  // }
}
