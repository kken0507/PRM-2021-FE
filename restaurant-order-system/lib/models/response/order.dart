import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/models/response/order_detail.dart';
import 'package:kiennt_restaurant/models/response/order_status.dart';
import 'package:kiennt_restaurant/util/my_util.dart';

class OrderResponse {
  int _orderId;
  List<OrderDetailResponse> _orderDetails;
  List<OrderStatusResponse> _orderStatus;
  OrderStatusResponse _curOrderStatus;
  DateTime _createdAt;

  // constructor
  OrderResponse({
    int orderId,
    List<OrderDetailResponse> orderDetails,
    List<OrderStatusResponse> orderStatus,
    OrderStatusResponse curOrderStatus,
    DateTime createdAt,
  }) {
    this._orderId = orderId;
    this._orderDetails = orderDetails;
    this._orderStatus = orderStatus;
    this._curOrderStatus = curOrderStatus;
    this._createdAt = createdAt;
  }

  // Properties
  int get orderId => _orderId;
  set orderId(int orderId) => _orderId = orderId;
  List<OrderDetailResponse> get orderDetails => _orderDetails;
  set orderDetails(List<OrderDetailResponse> orderDetails) =>
      _orderDetails = orderDetails;
  List<OrderStatusResponse> get orderStatus => _orderStatus;
  set orderStatus(List<OrderStatusResponse> orderStatus) =>
      _orderStatus = orderStatus;
  OrderStatusResponse get curOrderStatus => _curOrderStatus;
  set curOrderStatus(OrderStatusResponse curOrderStatus) => _curOrderStatus = curOrderStatus;
  DateTime get createdAt => _createdAt;
  set createdAt(DateTime createdAt) => _createdAt = createdAt;

  // create the user object from json input
  OrderResponse.fromJson(Map<String, dynamic> json) {
    _orderId = json['id'];

    _curOrderStatus = OrderStatusResponse.fromJson(json['curOrderStatus']);
    
    _orderDetails = [];
    _orderStatus = [];


    for (var i = 0; i < json['orderDetails'].length; i++) {
      OrderDetailResponse tmp =
          OrderDetailResponse.fromJson(json['orderDetails'][i]);
      if (tmp != null) {
        _orderDetails.add(tmp);
      }
    }
    for (var i = 0; i < json['orderStatus'].length; i++) {
      OrderStatusResponse tmp =
          OrderStatusResponse.fromJson(json['orderStatus'][i]);
      tmp != null ? _orderStatus.add(tmp) : {};
    }
    _orderStatus.sort((a,b) => a.createdAt.compareTo(b.createdAt));
    _createdAt = MyUtil().convertArrayToDateTime(json['createdAt']);
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._orderId;
    data['orderDetails'] = this._orderDetails;
    data['orderStatus'] = this._orderStatus;
    data['curOrderStatus'] = this._curOrderStatus;
    data['createdAt'] = this._createdAt;
    return data;
  }
}
