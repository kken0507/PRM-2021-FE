import 'dart:convert';

import 'package:kiennt_restaurant/models/common/item.dart';
import 'package:kiennt_restaurant/models/common/order.dart';

class OrderDetail {
  int _orderDetailId;
  int _quantity;
  Item _item;
  Order _order;

  // constructor
  OrderDetail({
  int orderDetailId,
  int quantity,
  Item item,
  Order order,
  }) {
    this._orderDetailId = orderDetailId;
    this._quantity = quantity;
    this._item = item;
    this._order = order;
  }

  // Properties
  int get orderDetailId => _orderDetailId;
  set orderDetailId(int orderDetailId) => _orderDetailId = orderDetailId;
  int get quantity => _quantity;
  set quantity(int quantity) => _quantity = quantity;
  Item get item => _item;
  set item(Item item) => _item = item;
  Order get order => _order;
  set order(Order order) => _order = order;

  // create the user object from json input
  OrderDetail.fromJson(Map<String, dynamic> json) {
    _orderDetailId = json['id'];
    _quantity = json['quantity'];
    _item = Item.fromJson(json['item']);
    _order = Order.fromJson(json['order']);
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._orderDetailId;
    data['quantity'] = this._quantity;
    data['item'] = this._item;
    data['order'] = this._order;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _orderDetailId,
      'quantity': _quantity,
      'item': _item.toMap(),
      'order': _order.toMap(),
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      orderDetailId: map['id'],
      quantity: map['quantity'],
      item: Item.fromMap(map['item']),
      order: map.containsKey('order') ? Order.fromMap(map['order']) : null,
    );
  }

}
