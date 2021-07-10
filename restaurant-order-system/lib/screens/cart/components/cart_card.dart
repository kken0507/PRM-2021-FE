import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/models/cart_item.dart';

import 'package:kiennt_restaurant/constants/constants.dart';
import 'package:kiennt_restaurant/configs/size_config.dart';
import 'package:kiennt_restaurant/models/shopping_cart.dart';

import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key key,
    @required this.cartItem,
  }) : super(key: key);

  // final Cart cart;
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(15),
              ), child:  Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(cartItem.item.img),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartItem.item.name,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\VND${cartItem.item.price}",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: kTextColor),
                // children: [
                //   TextSpan(
                //       text: " x${cart.numOfItem}",
                //       style: Theme.of(context).textTheme.bodyText1),
                // ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                  height: 30.0,
                  width: 30.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: "btn1_"+ cartItem.item.id.toString(),
                      onPressed: () =>
                          context.read<ShoppingCart>().add(cartItem.item),
                      child: new Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                // new Container(
                //     width: 20.0,
                //     height: 20.0,
                //     child: new RawMaterialButton(
                //       shape: new CircleBorder(),
                //       elevation: 0.0,
                //       child: new Icon(
                //         Icons.add,
                //         color: Colors.black,
                //       ),
                //       onPressed: () =>
                //           context.read<ShoppingCart>().add(cart.item),
                //     )),
                // new FloatingActionButton(
                //   onPressed: () =>
                //       context.read<ShoppingCart>().add(cart.item),
                //   child: new Icon(
                //     Icons.add,
                //     color: Colors.black,
                //   ),
                //   backgroundColor: Colors.white,
                // ),
                new Text('   ${cartItem.numOfItem}   ',
                    style: new TextStyle(fontSize: 15.0)),
                // new Container(
                //     width: 20.0,
                //     height: 20.0,
                //     child: new RawMaterialButton(
                //       shape: new CircleBorder(),
                //       elevation: 0.0,
                //       child: new Icon(Icons.remove, color: Colors.black),
                //       onPressed: () =>
                //           context.read<ShoppingCart>().reduce(cart.item),
                //     )),
                new Container(
                  height: 30.0,
                  width: 30.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: "btn2_"+ cartItem.item.id.toString(),
                      onPressed: () =>
                          context.read<ShoppingCart>().reduce(cartItem.item),
                      child: new Icon(Icons.remove, color: Colors.black),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                // new FloatingActionButton(
                //   onPressed: () =>
                //       context.read<ShoppingCart>().reduce(cart.item),
                //   child: new Icon(Icons.remove, color: Colors.black),
                //   backgroundColor: Colors.white,
                // ),
              ],
            ),
          ],
        )
      ],
    ),);
  }
}
