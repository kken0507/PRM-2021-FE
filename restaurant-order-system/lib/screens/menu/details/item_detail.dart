import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/item.dart';
import 'package:kiennt_restaurant/models/shopping_cart.dart';
import 'package:kiennt_restaurant/screens/menu/details/components/body.dart';
import 'package:kiennt_restaurant/util/my_util.dart';
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:provider/provider.dart';

class ItemDetail extends StatelessWidget {

  static String routeName = "/item-detail";

  @override
  Widget build(BuildContext context) {
    final Item item = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: ThemeColors.bgColorScreen,
      appBar: Navbar(
        title: "Detail",
        backButton: true,
      ),
      body: Body(item: item, ontap: () {context.read<ShoppingCart>().add(item); MyUtil.showSnackBar(context, "Item added to cart");},),
    );
  }
}
