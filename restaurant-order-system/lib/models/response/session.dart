import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kiennt_restaurant/models/response/order.dart';

class SessionResponse {
  int _sessionId;
  String _sessionNumber;
  String _position;
  String _status;
  List<OrderResponse> _orders;

  // constructor
  SessionResponse(
      {int sessionId,
      String sessionNumber,
      String position,
      String status,
      List<OrderResponse> orders}) {
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
  List<OrderResponse> get orders => _orders;
  set orders(List<OrderResponse> orders) => _orders = orders;

  // create the user object from json input
  SessionResponse.fromJson(Map<String, dynamic> myJson) {
    _sessionId = myJson['id'];
    _sessionNumber = myJson['sessionNumber'];
    _position = myJson['position'];
    _status = myJson['status'];
    _orders = [];


    for (var i = 0; i < myJson['orders'].length; i++) {
      OrderResponse tmp = OrderResponse.fromJson(myJson['orders'][i]);
      _orders.add(tmp);
    }
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sessionId'] = this._sessionId;
    data['sessionNumber'] = this._sessionNumber;
    data['position'] = this._position;
    data['status'] = this._status;
    data['orders'] = json.encoder.convert(this._orders);
    return data;
  }
}
