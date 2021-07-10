import 'dart:convert';

import 'package:kiennt_restaurant/models/common/order.dart';
import 'package:kiennt_restaurant/util/my_util.dart';

class OrderStatus {
  int _orderStatusId;
  String _content;
  String _status;
  DateTime _createdAt;
  Order _order;

  // constructor
  OrderStatus({
  int orderStatusId,
  String content,
  String status,
  DateTime createdAt,
  Order order,
  }) {
    this._orderStatusId = orderStatusId;
    this._content = content;
    this._createdAt = createdAt;
    this._status = status;
    this._order = order;
  }

  // Properties
  int get orderStatusId => _orderStatusId;
  set orderStatusId(int orderStatusId) => _orderStatusId = orderStatusId;
  String get content => _content;
  set content(String content) => _content = content;
  String get status => _status;
  set status(String status) => _status = status;
  DateTime get createdAt => _createdAt;
  set createdAt(DateTime createdAt) => _createdAt = createdAt;
  Order get order => _order;
  set order(Order order) => _order = order;

  // create the user object from json input
  OrderStatus.fromJson(Map<String, dynamic> json) {
    _orderStatusId = json['id'];
    _content = json['content'];
    _createdAt = MyUtil().convertArrayToDateTime(json['createdAt']);
    _status = json['status'];
    _order = Order.fromJson(json['order']);
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._orderStatusId;
    data['content'] = this._content;
    data['createdAt'] = this._createdAt;
    data['status'] = this._status;
    data['order'] = this._order;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _orderStatusId,
      'content': _content,
      'status': _status,
      'createdAt': _createdAt.millisecondsSinceEpoch,
      'order': _order.toMap(),
    };
  }

  factory OrderStatus.fromMap(Map<String, dynamic> map) {
    return OrderStatus(
      orderStatusId: map['id'],
      content: map['content'],
      status: map['status'],
      createdAt: MyUtil().convertArrayToDateTime(map['createdAt']),
      order: map.containsKey('order') ? Order.fromMap(map['order']) : null,
    );
  }

}
