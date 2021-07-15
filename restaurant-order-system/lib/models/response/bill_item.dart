import 'dart:convert';

import 'package:kiennt_restaurant/models/common/item.dart';

class BillItemResponse {
  Item _item;
  int _quantity;

  Item get item => this._item;

  set item(Item value) => this._item = value;

  get quantity => this._quantity;

  set quantity(value) => this._quantity = value;

  Map<String, dynamic> toMap() {
    return {
      'item': _item.toMap(),
      'itemQuantity': _quantity,
    };
  }

  // constructor
  BillItemResponse({
    int quantity,
    Item item,
  }) {
    this._quantity = quantity;
    this._item = item;
  }

  factory BillItemResponse.fromMap(Map<String, dynamic> map) {
    return BillItemResponse(
      item: Item.fromMap(map['item']),
      quantity: map['quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BillItemResponse.fromJson(String source) =>
      BillItemResponse.fromMap(json.decode(source));
}
