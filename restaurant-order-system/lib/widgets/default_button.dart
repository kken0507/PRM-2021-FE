import 'package:flutter/material.dart';

import 'package:kiennt_restaurant/constants/constants.dart';
import 'package:kiennt_restaurant/configs/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
    this.color,
  }) : super(key: key);
  final String text;
  final Function press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56.0),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: color ?? kPrimaryColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18.0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
