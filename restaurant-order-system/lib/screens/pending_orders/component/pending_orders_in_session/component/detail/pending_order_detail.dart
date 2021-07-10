import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/response/order.dart';
import 'package:kiennt_restaurant/models/response/session.dart';
import 'package:kiennt_restaurant/screens/pending_orders/component/pending_orders_in_session/component/detail/components/body.dart';
import 'package:kiennt_restaurant/screens/pending_orders/component/pending_orders_in_session/component/detail/components/bottom.dart';
import 'package:kiennt_restaurant/screens/pending_orders/component/pending_orders_in_session/pending_orders_in_session.dart';
import 'package:kiennt_restaurant/widgets/navbar.dart';

class PendingOrderDetailScreen extends StatelessWidget {
  static String routeName = "/pending-order-detail";

  @override
  Widget build(BuildContext context) {
    final SessionResponse session =
        (ModalRoute.of(context).settings.arguments as ScreenArguments).session;
    final OrderResponse order =
        (ModalRoute.of(context).settings.arguments as ScreenArguments).order;
    return Scaffold(
      backgroundColor: ThemeColors.bgColorScreen,
      appBar: Navbar(
        title: "Detail",
        rightOptionCart: false,
        backButton: true,
      ),
      body: Body(
        order: order,
        session: session,
      ),
      bottomNavigationBar: Bottom(order: order,),
    );
  }
}
