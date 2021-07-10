import 'package:flutter/material.dart';

class OrderDetail {
  int _itemId;
  int _quantity;

  // constructor
  OrderDetail({
    int itemId,
    int quantity,
  }) {
    this._itemId = itemId;
    this._quantity = quantity;
  }

  // Properties
  int get itemId => _itemId;
  set itemId(int itemId) => _itemId = itemId;
  int get quantity => _quantity;
  set quantity(int quantity) => _quantity = quantity;

  // create the user object from json input
  OrderDetail.fromJson(Map<String, dynamic> json) {
    _itemId = json['itemId'];
    _quantity = json['quantity'];
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this._itemId;
    data['quantity'] = this._quantity;
    return data;
  }
}
