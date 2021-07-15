import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kiennt_restaurant/models/cart_item.dart';

import 'package:kiennt_restaurant/configs/size_config.dart';
import 'package:kiennt_restaurant/models/shopping_cart.dart';
import 'cart_card.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    List<CartItem> _list = context.watch<ShoppingCart>().items;

    SizeConfig().init(context);
    
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20.0)),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _list.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(_list[index].item.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                context.read<ShoppingCart>().delete(_list[index].item);
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(cartItem: _list[index]),
          ),
        ),
      ),
    );
  }
}
