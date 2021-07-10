import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/models/response/item.dart';

class OrderDetailResponse {
  int _orderDetailId;
  int _quantity;
  ItemResponse _item;

  // constructor
  OrderDetailResponse({
  int orderDetailId,
  int quantity,
  ItemResponse item
  }) {
    this._orderDetailId = orderDetailId;
    this._quantity = quantity;
    this._item = item;
  }

  // Properties
  int get orderDetailId => _orderDetailId;
  set orderDetailId(int orderDetailId) => _orderDetailId = orderDetailId;
  int get quantity => _quantity;
  set quantity(int quantity) => _quantity = quantity;
  ItemResponse get item => _item;
  set item(ItemResponse item) => _item = item;

  // create the user object from json input
  OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    _orderDetailId = json['id'];
    _quantity = json['quantity'];
    _item = ItemResponse.fromJson(json['item']);
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._orderDetailId;
    data['quantity'] = this._quantity;
    data['item'] = this._item;
    return data;
  }
}
