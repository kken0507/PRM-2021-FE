import 'dart:convert';

import 'package:kiennt_restaurant/models/common/item.dart';

class BillItemResponse {
  Item _item;
  int _quantity;
  double _price;

  double get price => this._price;

  set price(double value) => this._price = value;

  Item get item => this._item;

  set item(Item value) => this._item = value;

  get quantity => this._quantity;

  set quantity(value) => this._quantity = value;

  Map<String, dynamic> toMap() {
    return {
      'item': _item.toMap(),
      'quantity': _quantity,
      'price': _price,
    };
  }

  // constructor
  BillItemResponse({
    int quantity,
    double price,
    Item item,
  }) {
    this._quantity = quantity;
    this._price = price;
    this._item = item;
  }

  factory BillItemResponse.fromMap(Map<String, dynamic> map) {
    return BillItemResponse(
      item: Item.fromMap(map['item']),
      quantity: map['quantity'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BillItemResponse.fromJson(String source) =>
      BillItemResponse.fromMap(json.decode(source));
}
