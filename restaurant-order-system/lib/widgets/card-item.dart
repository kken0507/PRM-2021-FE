import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';

class CardItem extends StatelessWidget {
  CardItem(
      {this.title = "Placeholder Title",
      this.cta = "",
      this.description = "",
      this.price = 0,
      this.img = "https://via.placeholder.com/200",
      this.onTap = defaultFunc});

  final String cta;
  final String img;
  final Function onTap;
  final String title;
  final String description;
  final double price;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 0.6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0)),
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          ))),
                ),
                Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 13)),
                          Text(description,
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 11)),
                          Text(price.toString() + "VND",
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 11)),
                          Text(cta,
                              style: TextStyle(
                                  color: ThemeColors.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
