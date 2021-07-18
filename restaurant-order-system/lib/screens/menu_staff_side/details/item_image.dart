import 'package:flutter/material.dart';

class ItemImage extends StatefulWidget {
  final String imgSrc;
  const ItemImage({
    Key key,
    this.imgSrc,
  }) : super(key: key);

  @override
  _ItemImageState createState() => _ItemImageState();
}

class _ItemImageState extends State<ItemImage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.network(
      (widget.imgSrc != null && widget.imgSrc.isNotEmpty) ? widget.imgSrc :
          "https://www.ncenet.com/wp-content/uploads/2020/04/No-image-found.jpg",
      height: size.height * 0.4,
      width: double.infinity,
      // it cover the 25% of total height
      fit: BoxFit.fill,
    );
  }
}