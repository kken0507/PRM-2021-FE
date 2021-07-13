import 'package:kiennt_restaurant/models/common/category.dart';

class Item {
  int _id;
  String _name;
  double _price;
  String _description;
  bool _available;
  String _img;
  Category _category;

  // constructor
  Item(
      {int id,
      String name,
      double price,
      String description,
      bool available,
      String img,
      Category category,}) {
    this._id = id;
    this._name = name;
    this._price = price;
    this._description = description;
    this._available = available;
    this._img = img;
    this._category = category;
  }

  Item.withItem(item) {
    this._id = item['id'];
    this._name = item['name'];
    this._price = item['price'];
    this._description = item['description'];
    this._available = item['isAvailable'];
    this._img = item['img'];
    this._category = item['category'];
  }

  // Properties
  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  double get price => _price;
  set price(double price) => _price = price;
  String get description => _description;
  set description(String description) => _description = description;
  bool get available => _available;
  set available(bool available) => _available = available;
  String get img => _img;
  set img(String img) => _img = img;
  Category get category => _category;
  set category(Category category) => _category = category;

  // create the user object from json input
  Item.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _description = json['description'];
    _available = json['isAvailable'];
    _img = json['img'];
    _category = json['category'];
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['price'] = this._price;
    data['description'] = this._description;
    data['isAvailable'] = this._available;
    data['img'] = this._img;
    return data;
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'price': _price,
      'description': _description,
      'isAvailable': _available,
      'img': _img,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
      available: map['isAvailable'],
      img: map['img'],
    );
  }

}
