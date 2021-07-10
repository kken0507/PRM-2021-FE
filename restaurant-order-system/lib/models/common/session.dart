import 'dart:convert';

import 'package:kiennt_restaurant/models/common/order.dart';

class Session {
  int _sessionId;
  String _sessionNumber;
  String _position;
  String _status;
  List<Order> _orders;

  // constructor
  Session(
      {int sessionId,
      String sessionNumber,
      String position,
      String status,
      List<Order> orders}) {
    this._sessionId = sessionId;
    this._sessionNumber = sessionNumber;
    this._position = position;
    this._status = status;
    this._orders = orders;
  }

  // Properties
  int get sessionId => _sessionId;
  set sessionId(int sessionId) => _sessionId = sessionId;
  String get sessionNumber => _sessionNumber;
  set sessionNumber(String sessionNumber) => _sessionNumber = sessionNumber;
  String get position => _position;
  set position(String position) => _position = position;
  String get status => _status;
  set status(String status) => _status = status;
  List<Order> get orders => _orders;
  set orders(List<Order> orders) => _orders = orders;

  // create the user object from json input
  Session.fromJson(Map<String, dynamic> myJson) {
    _sessionId = myJson['id'];
    _sessionNumber = myJson['sessionNumber'];
    _position = myJson['position'];
    _status = myJson['status'];
    _orders = [];


    for (var i = 0; i < myJson['orders'].length; i++) {
      Order tmp = Order.fromJson(myJson['orders'][i]);
      _orders.add(tmp);
    }
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._sessionId;
    data['sessionNumber'] = this._sessionNumber;
    data['position'] = this._position;
    data['status'] = this._status;
    data['orders'] = json.encoder.convert(this._orders);
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _sessionId,
      'sessionNumber': _sessionNumber,
      'position': _position,
      'status': _status,
      'orders': _orders?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      sessionId: map['id'],
      sessionNumber: map['sessionNumber'],
      position: map['position'],
      status: map['status'],
      orders: List<Order>.from(map['orders']?.map((x) => Order.fromMap(x))),
    );
  }


}
