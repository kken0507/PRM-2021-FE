class Item {
  int _id;
  String _name;
  double _price;
  String _description;
  bool _available;
  String _img;

  // constructor
  Item(
      {int id,
      String name,
      double price,
      String description,
      bool available,
      String img}) {
    this._id = id;
    this._name = name;
    this._price = price;
    this._description = description;
    this._available = available;
    this._img = img;
  }

  Item.withItem(item) {
    this._id = item['id'];
    this._name = item['name'];
    this._price = item['price'];
    this._description = item['description'];
    this._available = item['isAvailable'];
    this._img = item['img'];
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

  // create the user object from json input
  Item.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _description = json['description'];
    _available = json['isAvailable'];
    _img = json['img'];
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
}

List<Item> demoItems = [
  Item(
      id: 1,
      name: "test1",
      available: true,
      description: "test des",
      img:
          "https://st2.depositphotos.com/2461721/8057/i/950/depositphotos_80575630-stock-photo-ice-coffee.jpg",
      price: 15000),
  Item(
      id: 2,
      name: "test2",
      available: true,
      description: "test des",
      img:
          "https://st2.depositphotos.com/3935465/6480/i/950/depositphotos_64809727-stock-photo-fresh-homemade-whole-wheat-bread.jpg",
      price: 18000),
];
