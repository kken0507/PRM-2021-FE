import 'dart:convert';

import 'package:kiennt_restaurant/models/common/session.dart';

class BillResponse {
  Session _session;
  double _totalPrice;
  int _totalItemQuantity;

 Session get session => this._session;

 set session(Session value) => this._session = value;

  get totalPrice => this._totalPrice;

 set totalPrice( value) => this._totalPrice = value;

  get totalItemQuantity => this._totalItemQuantity;

 set totalItemQuantity( value) => this._totalItemQuantity = value;

  BillResponse(
      {Session session,
      double totalPrice,
      int totalItemQuantity,}) {
    this._session = session;
    this._totalPrice = totalPrice;
    this._totalItemQuantity = totalItemQuantity;
  }
  


  Map<String, dynamic> toMap() {
    return {
      'session': _session.toMap(),
      'totalPrice': _totalPrice,
      'totalItemQuantity': _totalItemQuantity,
    };
  }

  factory BillResponse.fromMap(Map<String, dynamic> map) {
    return BillResponse(
      session: map.containsKey('session') ? Session.fromMap(map['session']) : null,
      totalPrice: map.containsKey('session') ? map['totalPrice'] : null,
      totalItemQuantity: map.containsKey('session') ? map['totalItemQuantity'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BillResponse.fromJson(String source) => BillResponse.fromMap(json.decode(source));
}
