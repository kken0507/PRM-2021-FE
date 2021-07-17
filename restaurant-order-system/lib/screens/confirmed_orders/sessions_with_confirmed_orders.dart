import 'dart:async';

import 'package:flutter/material.dart';

import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/response/session.dart';
import 'package:kiennt_restaurant/screens/confirmed_orders/component/confirmed_orders_in_session/confirmed_orders_in_session.dart';
import 'package:kiennt_restaurant/screens/confirmed_orders/component/session_card.dart';
import 'package:kiennt_restaurant/services/api.dart';

//widgets
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:kiennt_restaurant/widgets/drawer.dart';

class ConfirmedOrdersScreen extends StatefulWidget {
  const ConfirmedOrdersScreen({Key key}) : super(key: key);

  static String routeName = "/confirmed-orders";

  @override
  _ConfirmedOrdersScreenState createState() => _ConfirmedOrdersScreenState();
}

class _ConfirmedOrdersScreenState extends State<ConfirmedOrdersScreen> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  List<SessionResponse> _list = [];
  List<SessionResponse> _listForDisplay = [];

  @override
  void initState() {
    super.initState();
    initializeList();
  }

  Future<void> initializeList() async {
    _list = await MyApi().getSessionOrdersByStatus('CONFIRMED');
    // if (_list.isNotEmpty) {
    //   setState(() {
    //     _listForDisplay = _list;
    //   });
    // }
    setState(() {
      _listForDisplay = _list;
    });
  }

  FutureOr onGoBack(dynamic value) {
    initializeList();
  }

  Future<void> pullRefresh() async {
    initializeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Confirmed orders",
        rightOptionCart: false,
        searchBar: true,
        placeholder: "By session number or pos...",
        searchOnChanged: (str) {
          String tmp = str;
          tmp = tmp.toLowerCase();
          Set<SessionResponse> listTmp = _list.where((item) {
            var sessionNumber = item.sessionNumber.toLowerCase();
            return sessionNumber.contains(tmp);
          }).toSet();
          listTmp.addAll(_list.where((item) {
            var position = item.position.toLowerCase();
            return position.contains(tmp);
          }).toList());
          setState(() {
            _listForDisplay = listTmp.toList();
          });
        },
      ),
      backgroundColor: ThemeColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: ArgonDrawer(currentPage: "Confirmed"),
      // body: FutureBuilder<List<SessionResponse>>(
      //   future: MyApi().getSessionOrdersByStatus('PENDING'),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting)
      //       return LinearProgressIndicator();
      //     if (snapshot.hasData) {
      //       if (snapshot.data != null) {
      //         return Container(
      //             child: Center(
      //           child: ListView.builder(
      //             physics: BouncingScrollPhysics(),
      //             scrollDirection: Axis.vertical,
      //             itemCount: snapshot.data.length,
      //             itemBuilder: (context, index) {
      //               return CardSession(
      //                 sessionNum: snapshot.data[index].sessionNumber,
      //                 orderQuantity: snapshot.data[index].orders.length,
      //                 position: snapshot.data[index].position,
      //                 onTap: () {
      //                   Navigator.pushNamed(
      //                       context, PendingOrdersInASessionScreen.routeName,
      //                       arguments: snapshot.data[index]).then(onGoBack);
      //                 },
      //               );
      //             },
      //           ),
      //         ));
      //       }

      //       if (snapshot.data == null)
      //         return Center(
      //           child: Text('Empty'),
      //         );
      //     }
      //     return Center(
      //       child: Text('Error, try again!'),
      //     );
      //   },
      // ),
      body: Container(
          child: Center(
              child: RefreshIndicator(
        onRefresh: pullRefresh,
        child: ListView.builder(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          scrollDirection: Axis.vertical,
          itemCount: _listForDisplay.length,
          itemBuilder: (context, index) {
            return CardSession(
              sessionNum: _listForDisplay[index].sessionNumber,
              orderQuantity: _listForDisplay[index].orders.length,
              position: _listForDisplay[index].position,
              onTap: () {
                Navigator.pushNamed(
                        context, ConfirmedOrdersInASessionScreen.routeName,
                        arguments: _listForDisplay[index])
                    .then(onGoBack);
              },
            );
          },
        ),
      ))),
    );
  }
}
