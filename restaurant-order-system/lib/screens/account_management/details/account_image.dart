import 'package:flutter/material.dart';

class AccountImage extends StatefulWidget {
  final String imgSrc;
  const AccountImage({
    Key key,
    this.imgSrc,
  }) : super(key: key);

  @override
  _AccountImageState createState() => _AccountImageState();
}

class _AccountImageState extends State<AccountImage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.network(
      widget.imgSrc ??
          "https://st2.depositphotos.com/1009634/7235/v/600/depositphotos_72350117-stock-illustration-no-user-profile-picture-hand.jpg",
      height: size.height * 0.4,
      width: double.infinity,
      // it cover the 25% of total height
      fit: BoxFit.fill,
    );
  }
}