import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/screens/menu/start_session.dart';
import 'package:kiennt_restaurant/services/storage/local_storage.dart';
import 'package:kiennt_restaurant/screens/menu/menu.dart';

class MenuDispatcher extends StatefulWidget {
  @override
  _MenuDispatcherState createState() => _MenuDispatcherState();

  static String routeName = "/menu";

}

class _MenuDispatcherState extends State<MenuDispatcher> {
  String _sessionId = "";

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  _loadSession() async {
    _sessionId = await LocalStorage.getSessionFromStorage();
    if (_sessionId != null) _sessionId = _sessionId.trim();

    if (_sessionId == "" || _sessionId == null) {
      Navigator.pushReplacementNamed(context, StartSessionScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, MenuScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
