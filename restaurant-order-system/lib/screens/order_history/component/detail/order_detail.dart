import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/response/order.dart';
import 'package:kiennt_restaurant/screens/order_history/component/detail/components/body.dart';
import 'package:kiennt_restaurant/widgets/navbar.dart';

class OrderDetailScreen extends StatelessWidget {
  static String routeName = "/order-detail";
// // Declare a field that holds the Item.
//   final Item item;

//   // In the constructor, require a Item.
//   ItemDetail({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderResponse order = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: ThemeColors.bgColorScreen,
      appBar: Navbar(
        title: "Detail",
        backButton: true,
      ),
      body: Body(order: order,),
    );
  }

}
