import 'dart:convert';

import 'package:kiennt_restaurant/models/common/session.dart';
import 'package:kiennt_restaurant/models/response/bill_item.dart';

class BillResponse {
  Session _session;
  double _totalPrice;
  int _totalItemQuantity;
  List<BillItemResponse> _items;

  List<BillItemResponse> get items => this._items;

  set items(List<BillItemResponse> value) => this._items = value;

  Session get session => this._session;

  set session(Session value) => this._session = value;

  get totalPrice => this._totalPrice;

  set totalPrice(value) => this._totalPrice = value;

  get totalItemQuantity => this._totalItemQuantity;

  set totalItemQuantity(value) => this._totalItemQuantity = value;

  BillResponse({
    Session session,
    double totalPrice,
    List<BillItemResponse> items,
    int totalItemQuantity,
  }) {
    this._session = session;
    this._totalPrice = totalPrice;
    this._totalItemQuantity = totalItemQuantity;
    this._items = items;
  }

  Map<String, dynamic> toMap() {
    return {
      'session': _session.toMap(),
      'totalPrice': _totalPrice,
      'totalItemQuantity': _totalItemQuantity,
      'items': _items?.map((x) => x.toMap())?.toList(),
    };
  }

  factory BillResponse.fromMap(Map<String, dynamic> map) {
    return BillResponse(
      session: Session.fromMap(map['session']),
      totalPrice: map['totalPrice'],
      totalItemQuantity: map['totalItemQuantity'],
      items: List<BillItemResponse>.from(
          map['items']?.map((x) => BillItemResponse.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BillResponse.fromJson(String source) =>
      BillResponse.fromMap(json.decode(source));
}
