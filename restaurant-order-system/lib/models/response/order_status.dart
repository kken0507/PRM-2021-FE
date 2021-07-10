import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/models/response/item.dart';
import 'package:kiennt_restaurant/util/my_util.dart';

class OrderStatusResponse {
  int _orderStatusId;
  String _content;
  String _status;
  DateTime _createdAt;

  // constructor
  OrderStatusResponse({
  int orderDetailId,
  String content,
  String status,
  DateTime createdAt,
  }) {
    this._orderStatusId = orderDetailId;
    this._content = content;
    this._createdAt = createdAt;
    this._status = status;
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

  // create the user object from json input
  OrderStatusResponse.fromJson(Map<String, dynamic> json) {
    
    
    _orderStatusId = json['id'];
    _content = json['content'];
    _createdAt = MyUtil().convertArrayToDateTime(json['createdAt']);
    _status = json['status'];
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._orderStatusId;
    data['content'] = this._content;
    data['createdAt'] = this._createdAt;
    data['status'] = this._status;
    return data;
  }
}
