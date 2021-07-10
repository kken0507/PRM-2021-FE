import 'dart:convert';

import 'package:kiennt_restaurant/models/common/item.dart';

class Category {
  int _id;
  String _name;
  List<Item> _items;

  Category({int id, String name, List<Item> items}) {
    this._id = id;
    this._name = name;
    this._items = items;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'items': _items?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      items: List<Item>.from(map['items']?.map((x) => Item.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
