import 'dart:async';

import 'package:flutter/material.dart';

import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/response/order.dart';
import 'package:kiennt_restaurant/models/response/session.dart';
import 'package:kiennt_restaurant/screens/confirmed_orders/component/confirmed_orders_in_session/component/confirmed_order_card.dart';
import 'package:kiennt_restaurant/screens/confirmed_orders/component/confirmed_orders_in_session/component/detail/confirmed_order_detail.dart';
import 'package:kiennt_restaurant/services/api.dart';

//widgets
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:kiennt_restaurant/widgets/drawer.dart';

class ConfirmedOrdersInASessionScreen extends StatefulWidget {
  const ConfirmedOrdersInASessionScreen({Key key}) : super(key: key);

  static String routeName = "/confirmed-orders-in-session";

  @override
  _ConfirmedOrdersInASessionScreenState createState() =>
      _ConfirmedOrdersInASessionScreenState();
}

class _ConfirmedOrdersInASessionScreenState
    extends State<ConfirmedOrdersInASessionScreen> {
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  Future<void> pullRefresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final SessionResponse session = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: Navbar(
          title: "#" + session.sessionNumber + " - " + session.position,
          backButton: true,
          rightOptionCart: false,
        ),
        backgroundColor: ThemeColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: ArgonDrawer(currentPage: "Pending"),
        body: FutureBuilder<SessionResponse>(
          future: MyApi()
              .getOpeningSessionOrdersByStatus(session.sessionId, "CONFIRMED"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return LinearProgressIndicator();
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return Container(
                    child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                            onRefresh: pullRefresh,
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.orders.length,
                              itemBuilder: (context, index) {
                                return CardConfirmedOrder(
                                  cta: "Press to view detail...",
                                  order: snapshot.data.orders[index],
                                  index: index + 1,
                                  onTap: () {
                                    Navigator.pushNamed(
                                            context,
                                            ConfirmedOrderDetailScreen
                                                .routeName,
                                            arguments: ScreenArguments(
                                                snapshot.data.orders[index],
                                                snapshot.data))
                                        .then(onGoBack);
                                  },
                                );
                              },
                            )),
                      )
                    ],
                  ),
                ));
              }

              if (snapshot.data == null)
                return Center(
                  child: Text('Empty'),
                );
            }
            return Center(
              child: Text('Error, try again!'),
            );
          },
        ));
  }
}

class ScreenArguments {
  final OrderResponse order;
  final SessionResponse session;

  ScreenArguments(this.order, this.session);
}
