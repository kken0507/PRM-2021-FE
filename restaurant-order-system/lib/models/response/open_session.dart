import 'package:flutter/material.dart';

class OpenSessionResponse {
  int _sessionId;
  String _sessionNumber;
  String _position;
  String _status;

  // constructor
  OpenSessionResponse({
    int sessionId,
  String sessionNumber,
  String position,
  String status,
  }) {
    this._sessionId = sessionId;
    this._sessionNumber = sessionNumber;
    this._position = position;
    this._status = status;
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

  // create the user object from json input
  OpenSessionResponse.fromJson(Map<String, dynamic> json) {
    _sessionId = json['sessionId'];
    _sessionNumber = json['sessionNumber'];
    _position = json['position'];
    _status = json['status'];
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sessionId'] = this._sessionId;
    data['sessionNumber'] = this._sessionNumber;
    data['position'] = this._position;
    data['status'] = this._status;
    return data;
  }
}
