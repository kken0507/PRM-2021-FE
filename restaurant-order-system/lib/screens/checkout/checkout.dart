import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/screens/checkout/components/body.dart';
import 'package:kiennt_restaurant/screens/checkout/components/bottom.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/widgets/drawer.dart';
import 'package:kiennt_restaurant/widgets/navbar.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key key}) : super(key: key);

  static String routeName = "/checkout";

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  Future<void> pullRefresh() async {
    setState(() {});
  }

  _body() {
    return FutureBuilder(
      future: MyApi().getBill(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Body(
            bill: snapshot.data, onRefresh: pullRefresh,
          );
        } else {
          return Container();
        }
      },
    );
  }

  _bottom() {
    return FutureBuilder(
      future: MyApi().getBill(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Bottom(
            bill: snapshot.data,
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Checkout"),
      appBar: Navbar(
        title: "Checkout",
        // backButton: true,
        rightOptionCart: false,
      ),
      body: _body(),
      bottomNavigationBar: _bottom(),
    );
  }
}
