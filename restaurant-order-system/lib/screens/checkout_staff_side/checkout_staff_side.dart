import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/response/bill.dart';
import 'package:kiennt_restaurant/screens/checkout_staff_side/components/body.dart';
import 'package:kiennt_restaurant/screens/checkout_staff_side/components/bottom.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/screens/menu/menu.dart';
import 'package:kiennt_restaurant/util/dialog_util.dart';

//widgets
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:kiennt_restaurant/widgets/drawer.dart';

class CheckoutStaffScreen extends StatefulWidget {
  CheckoutStaffScreen({Key key, this.title}) : super(key: key);
  final String title;

  static String routeName = "/checkout-staff";

  @override
  _CheckoutStaffScreenState createState() => _CheckoutStaffScreenState();
}

class _CheckoutStaffScreenState extends State<CheckoutStaffScreen> {
  ScanResult scanResult;

  Future _scan() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'camera access denied';
        });
      } else {
        result.rawContent = 'Error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }

  _body() {
    return FutureBuilder(
      future: MyApi().getBillBySessionNum(scanResult != null ? (scanResult.rawContent ?? "") : ""),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Body(
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
      appBar: Navbar(
        title: "Checkout",
        rightOptionCart: false,
      ),
      backgroundColor: ThemeColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: ArgonDrawer(currentPage: "Checkout Staff"),
      body: _body(),
      bottomNavigationBar:
          Bottom(sessionNumber: scanResult != null ? (scanResult.rawContent ?? "") : "", onPress: _scan),
    );
  }
}