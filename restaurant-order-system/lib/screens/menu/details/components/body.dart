import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/item.dart';
import 'package:kiennt_restaurant/screens/menu/details/components/item_image.dart';
import 'package:kiennt_restaurant/screens/menu/details/components/order_button.dart';
import 'package:kiennt_restaurant/screens/menu/details/components/title_price_rating.dart';

class Body extends StatelessWidget {
  // Declare a field that holds the Item.
  final Item item;
  // Declare a field that holds the Item.
  final Function ontap;

  // In the constructor, a Item, function onTap.
  Body({Key key, this.item, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: Column(
          children: <Widget>[
            ItemImage(
              imgSrc: item.img,
            ),
            Expanded(
              child: ItemInfo(
                item: item,
                ontap: ontap,
              ),
            ),
          ],
        ));
  }
}

class ItemInfo extends StatelessWidget {
  // Declare a field that holds the Item.
  final Item item;
  // Declare a field that holds the Item.
  final Function ontap;

  // In the constructor, a Item, function onTap.
  ItemInfo({Key key, this.item, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 2;
    return Container(
      padding: EdgeInsets.all(1),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: <Widget>[
          // shopeName(name: "MacDonalds"),
          TitlePriceRating(
            name: item.name,
            // numOfReviews: 24,
            // rating: 4,
            price: item.price,
            // onRatingChanged: (value) {},
          ),
          Text(
            "Description:",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: ThemeColors.text),
          ),
          SizedBox(height: size.height * 0.1),
          Text(
            item.description,
            style: TextStyle(
              height: 1,
            ),
          ),
          SizedBox(height: size.height * 0.1),
          // Free space  10% of total height
          OrderButton(
            size: size,
            press: ontap,
          )
        ],
      ),
    );
  }

  // Row shopeName({String name}) {
  //   return Row(
  //     children: <Widget>[
  //       Icon(
  //         Icons.location_on,
  //         color: ksecondaryColor,
  //       ),
  //       SizedBox(width: 10),
  //       Text(name),
  //     ],
  //   );
  // }
}
