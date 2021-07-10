import 'package:flutter/material.dart';

import 'item.dart';

class CartItem {
  final Item item;
  final int numOfItem;

  CartItem({@required this.item, @required this.numOfItem});
}

// Demo data for our cart

List<CartItem> myDemoCarts = [
  CartItem(item: demoItems[0], numOfItem: 2),
  CartItem(item: demoItems[1], numOfItem: 1),
];
