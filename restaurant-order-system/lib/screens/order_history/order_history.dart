import 'dart:async';

import 'package:flutter/material.dart';

import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/response/session.dart';
import 'package:kiennt_restaurant/screens/order_history/component/detail/order_detail.dart';
import 'package:kiennt_restaurant/screens/order_history/component/order_card.dart';
import 'package:kiennt_restaurant/services/api.dart';

//widgets
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:kiennt_restaurant/widgets/drawer.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key key}) : super(key: key);

  static String routeName = "/order-history";

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  // final GlobalKey _scaffoldKey = new GlobalKey();

  List<SessionResponse> _list = [];
  List<SessionResponse> _listForDisplay = [];

  @override
  void initState() {
    super.initState();
    initializeList();
  }

  Future<void> initializeList() async {
    setState(() {});
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  Future<void> pullRefresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Order history",
        ),
        backgroundColor: ThemeColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: ArgonDrawer(currentPage: "History"),
        body: FutureBuilder<SessionResponse>(
          future: MyApi().getSession(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return LinearProgressIndicator();
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                // return ListView.builder(
                //   physics: BouncingScrollPhysics(),
                //   scrollDirection: Axis.vertical,
                //   itemCount: snapshot.data.length,
                //   itemBuilder: (context, index) {
                //     return CardItem(
                //         cta: "Press to view detail...",
                //         title: (snapshot.data[index] as Item).name,
                //         description: (snapshot.data[index] as Item).description,
                //         price: (snapshot.data[index] as Item).price,
                //         img: (snapshot.data[index] as Item).img,
                //         onTap: () {
                //           Navigator.pushNamed(context, '/item-detail',
                //               arguments: (snapshot.data[index] as Item));
                //         });
                //   },
                // );

                return Container(
                    child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Card(
                          elevation: 0.6,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                    "Session #" + snapshot.data.sessionNumber,
                                    style: TextStyle(
                                        color: ThemeColors.header,
                                        fontSize: 13)),
                              )),
                        ),
                      ),
                      // CardOrder(
                      //   cta: "Press to view detail...",
                      //   status: "(snapshot.data[index] as Item).name",
                      //   id: 0,
                      //   index: 0,
                      // ),
                      Expanded(
                        child: RefreshIndicator(
                            onRefresh: pullRefresh,
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.orders.length,
                              itemBuilder: (context, index) {
                                return CardOrder(
                                  cta: "Press to view detail...",
                                  status: snapshot
                                      .data.orders[index].curOrderStatus.status,
                                  id: snapshot.data.orders[index].orderId,
                                  index: index + 1,
                                  orderedAt:
                                      snapshot.data.orders[index].createdAt,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, OrderDetailScreen.routeName,
                                        arguments: snapshot.data.orders[index]);
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
