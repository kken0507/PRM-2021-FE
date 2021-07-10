import 'dart:convert';

import 'package:kiennt_restaurant/models/common/order_detail.dart';
import 'package:kiennt_restaurant/models/common/order_status.dart';
import 'package:kiennt_restaurant/util/my_util.dart';

class Order {
  int _orderId;
  List<OrderDetail> _orderDetails;
  List<OrderStatus> _orderStatus;
  OrderStatus _curOrderStatus;
  DateTime _createdAt;

  // constructor
  Order({
    int orderId,
    List<OrderDetail> orderDetails,
    List<OrderStatus> orderStatus,
    OrderStatus curOrderStatus,
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
  List<OrderDetail> get orderDetails => _orderDetails;
  set orderDetails(List<OrderDetail> orderDetails) =>
      _orderDetails = orderDetails;
  List<OrderStatus> get orderStatus => _orderStatus;
  set orderStatus(List<OrderStatus> orderStatus) =>
      _orderStatus = orderStatus;
  OrderStatus get curOrderStatus => _curOrderStatus;
  set curOrderStatus(OrderStatus curOrderStatus) => _curOrderStatus = curOrderStatus;
  DateTime get createdAt => _createdAt;
  set createdAt(DateTime createdAt) => _createdAt = createdAt;

  // create the user object from json input
  Order.fromJson(Map<String, dynamic> json) {
    _orderId = json['id'];

    _curOrderStatus = OrderStatus.fromJson(json['curOrderStatus']);
    
    _orderDetails = [];
    _orderStatus = [];


    for (var i = 0; i < json['orderDetails'].length; i++) {
      OrderDetail tmp =
          OrderDetail.fromJson(json['orderDetails'][i]);
      if (tmp != null) {
        _orderDetails.add(tmp);
      }
    }
    for (var i = 0; i < json['orderStatus'].length; i++) {
      OrderStatus tmp =
          OrderStatus.fromJson(json['orderStatus'][i]);
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

  Map<String, dynamic> toMap() {
    return {
      'id': _orderId,
      'orderDetails': _orderDetails?.map((x) => x.toMap())?.toList(),
      'orderStatus': _orderStatus?.map((x) => x.toMap())?.toList(),
      'createdAt': _createdAt.millisecondsSinceEpoch,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['id'],
      orderDetails: List<OrderDetail>.from(map.containsKey('orderDetails') ? map['orderDetails']?.map((x) => OrderDetail.fromMap(x)) : List.empty()),
      orderStatus: List<OrderStatus>.from(map.containsKey('orderStatus') ? map['orderStatus']?.map((x) => OrderStatus.fromMap(x)) : List.empty()),
      createdAt: MyUtil().convertArrayToDateTime(map['createdAt']),
    );
  }

}
