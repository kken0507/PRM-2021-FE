import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/screens/login.dart';
import 'package:kiennt_restaurant/screens/menu/dispatcher.dart';
import 'package:kiennt_restaurant/screens/pending_orders/sessions_with_pending_orders.dart';
import 'package:kiennt_restaurant/services/storage/local_storage.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();

  static String routeName = "/landing";
}

class _LandingState extends State<Landing> {
  String _userId = "";
  String _role = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    _userId = await LocalStorage.getUserIdFromStorage();
    _role = await LocalStorage.getRoleFromStorage();

    if (_userId != null) _userId = _userId.trim();

    if (_userId == "" || _userId == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, Login.routeName, ModalRoute.withName(Login.routeName));
    } else {
      if (_role == "CUSTOMER") {
        Navigator.pushNamedAndRemoveUntil(context, MenuDispatcher.routeName,
            ModalRoute.withName(MenuDispatcher.routeName));
      }

      Navigator.pushNamedAndRemoveUntil(context, PendingOrdersScreen.routeName,
          ModalRoute.withName(PendingOrdersScreen.routeName));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
