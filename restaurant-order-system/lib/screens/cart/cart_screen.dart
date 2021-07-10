import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/models/shopping_cart.dart';
import 'package:kiennt_restaurant/widgets/navbar.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';
import 'package:provider/provider.dart';

// class CartScreen extends StatelessWidget {
//   static String routeName = "/cart";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(context),
//       body: Body(),
//       bottomNavigationBar: CheckoutCard(),
//     );
//   }

//   AppBar buildAppBar(BuildContext context) {
//     List<ShoppingCart> _list = context.watch<ShoppingCart>().items;
//     return AppBar(
//       title: Column(
//         children: [
//           Text(
//             "Your Cart",
//             style: TextStyle(color: Colors.black),
//           ),
//           Text(
//             // "${myDemoCarts.length} items",
//             "${_list.length} items",
//             style: Theme.of(context).textTheme.caption,
//           ),
//         ],
//       ),
//     );
//   }
// }

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
// final GlobalKey _scaffoldKey = new GlobalKey();
  int totalItemsQuantity = 0;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final shoppingCartsState = Provider.of<ShoppingCart>(context);
    setState(() {
        totalItemsQuantity = shoppingCartsState.totalItemsQuantity;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Your Cart - $totalItemsQuantity items",
        backButton: true,
        rightOptionCart: false,
      ),
      // appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            // "${myDemoCarts.length} items",
            "$totalItemsQuantity items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
