import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/models/cart_item.dart';

import 'item.dart';

class ShoppingCart with ChangeNotifier {
  final List<CartItem> _list = [];

  void add(Item item) {
    int itemIndex = _list.indexWhere((element) => element.item.id == item.id);
    if (itemIndex > -1) {
      _list[itemIndex] =
          CartItem(item: item, numOfItem: _list[itemIndex].numOfItem + 1);
    } else {
      _list.add(CartItem(item: item, numOfItem: 1));
    }
    notifyListeners();
  }

  void reduce(Item item) {
    int itemIndex = _list.indexWhere((element) => element.item.id == item.id);
    if (itemIndex > -1) {
      if (_list[itemIndex].numOfItem > 0) {
        _list[itemIndex] =
            CartItem(item: item, numOfItem: _list[itemIndex].numOfItem - 1);
        notifyListeners();
      } else {
        this.delete(item);
      }
    }
  }

  void delete(Item item) {
    int itemIndex = _list.indexWhere((element) => element.item.id == item.id);
    if (itemIndex > -1) {
      _list.removeAt(itemIndex);
    }
    notifyListeners();
  }

  void deleteAll() {
    _list.clear();
    notifyListeners();
  }

  List<CartItem> get items => _list;

  double get totalPrice => _list.fold(
      0, (total, current) => total + (current.item.price * current.numOfItem));

  int get totalItemsQuantity =>
      _list.fold(0, (total, current) => total + current.numOfItem);

  int getItemQuantity(Item item) {
    int itemIndex = _list.indexWhere((element) => element.item.id == item.id);
    if (itemIndex > -1) {
      return _list[itemIndex].numOfItem;
    } else {
      return 0;
    }
  }
}
