import 'dart:convert';

import 'package:kiennt_restaurant/util/my_util.dart';

class Account {
  int _id;
  String _email;
  String _role;
  bool _active;
  String _avatar;
  String _fullname;
  String _phone;
  String _gender;
  DateTime _dob;

  int get id => this._id;

  set id(int value) => this._id = value;

  get email => this._email;

  set email(value) => this._email = value;

  get role => this._role;

  set role(value) => this._role = value;

  get active => this._active;

  set active(value) => this._active = value;

  get avatar => this._avatar;

  set avatar(value) => this._avatar = value;

  get fullname => this._fullname;

  set fullname(value) => this._fullname = value;

  get phone => this._phone;

  set phone(value) => this._phone = value;

  get gender => this._gender;

  set gender(value) => this._gender = value;

  get dob => this._dob;

  set dob(value) => this._dob = value;

  Account(
      {int id,
      String email,
      String role,
      bool active,
      String avatar,
      String fullname,
      String phone,
      String gender,
      DateTime dob}) {
    this._id = id;
    this._email = email;
    this._role = role;
    this._active = active;
    this._avatar = avatar;
    this._fullname = fullname;
    this._phone = phone;
    this._gender = gender;
    this._dob = dob;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'email': _email,
      'role': _role,
      'isActive': _active,
      'avatar': _avatar,
      'fullname': _fullname,
      'phone': _phone,
      'gender': _gender,
      'dob': MyUtil().convertDateTimeToArray(_dob),
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      email: map['email'],
      role: map['role'],
      active: map['isActive'],
      avatar: map['avatar'],
      fullname: map['fullname'],
      phone: map['phone'],
      gender: map['gender'],
      dob: MyUtil().convertArrayToDateTime(map['dob']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Account(_id: $_id, _email: $_email, _role: $_role, _active: $_active, _avatar: $_avatar, _fullname: $_fullname, _phone: $_phone, _gender: $_gender, _dob: $_dob)';
  }
}
