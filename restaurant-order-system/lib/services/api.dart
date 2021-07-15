import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kiennt_restaurant/models/common/account.dart';
import 'package:kiennt_restaurant/models/item.dart';
import 'package:kiennt_restaurant/models/request/order_detail.dart';
import 'package:kiennt_restaurant/models/response/bill.dart';
import 'package:kiennt_restaurant/models/response/open_session.dart';
import 'package:kiennt_restaurant/models/response/session.dart';
import 'package:kiennt_restaurant/models/shopping_cart.dart';
import 'package:kiennt_restaurant/services/storage/local_storage.dart';

class MyApi {
  String _baseUrl = "http://192.168.2.174:8091/";

  Future<List<Item>> getItems() async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'item/all';
    List<Item> result = [];

    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      for (var i = 0; i < jsonList.length; i++) {
        Item tmp = Item.withItem(jsonList[i]);
        result.add(tmp);
      }
      return result;
    }
    return List.empty();
  }

  Future<List<Item>> searchItems(String name, String status) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'item/searchToList';
    url += ((name != null && name.isNotEmpty) ||
            (status != null && status.isNotEmpty))
        ? "/"
        : "";
    url += (name != null && name.isNotEmpty) ? "?name=" + name : "";
    url +=
        (status != null && status.isNotEmpty) ? "?isAvailable=" + status : "";
    List<Item> result = [];

    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      for (var i = 0; i < jsonList.length; i++) {
        Item tmp = Item.withItem(jsonList[i]);
        result.add(tmp);
      }
      return result;
    }
    return List.empty();
  }

  Future<bool> createOrder(ShoppingCart cart) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'order/create';
    List<OrderDetail> request = [];

    cart.items.forEach((element) => request.add(
        OrderDetail(itemId: element.item.id, quantity: element.numOfItem)));

    url += "?sessionId=" + await LocalStorage.getSessionFromStorage();

    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: json.encoder.convert(request.map((e) => e.toJson()).toList()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> openSession() async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'session/openSession';

    String position = await LocalStorage.getPositionFromStorage();

    if (position != null) {
      url += "?position=" + position;
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        OpenSessionResponse obj =
            OpenSessionResponse.fromJson(jsonDecode(response.body));
        LocalStorage.saveSession(obj.sessionId.toString());
        return true;
      }
    }
    return false;
  }

  Future<dynamic> closeSession(sessionId) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'session/closeSession/' + sessionId.toString();

    var response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print(jsonDecode(response.body)["message"]);
      // return false;
      return jsonDecode(response.body)["message"].toString();
    }
  }

  Future<bool> completeSession(sessionId) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'session/completeSession/' + sessionId.toString();

    var response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<SessionResponse> getSession() async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'session/getSession/';
    url += await LocalStorage.getSessionFromStorage();
    // url += "22"; // for quick testing

    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      SessionResponse obj = SessionResponse.fromJson(jsonDecode(response.body));
      if (obj != null) {
        return obj;
      }
    }

    return null;
  }

  Future<SessionResponse> getSessionById(int sessionId) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'session/getSession/';
    url += sessionId.toString();

    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      SessionResponse obj = SessionResponse.fromJson(jsonDecode(response.body));
      if (obj != null) {
        return obj;
      }
    }

    return null;
  }

  Future<List<SessionResponse>> getSessionOrdersByStatus(String status) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'session/getSessionsByOrderStatus?status=$status';

    List<SessionResponse> result = [];

    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      for (var i = 0; i < jsonList.length; i++) {
        SessionResponse tmp = SessionResponse.fromJson(jsonList[i]);
        result.add(tmp);
      }
      return result;
    }

    return null;
  }

  Future<bool> confirmOrder(orderId) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'order/confirmOrder/' + orderId.toString();

    var response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> declineOrder(orderId, reason) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'order/declineOrder/' + orderId.toString();

    var response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
      body: reason,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<SessionResponse> getOpeningSessionOrdersByStatus(
      sessionId, status) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url =
        _baseUrl + 'session/getOpeningSessionOrdersByOrderStatusAndSessionId/';
    url += sessionId.toString();
    url += "?status=$status";

    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      SessionResponse obj = SessionResponse.fromJson(jsonDecode(response.body));
      if (obj != null) {
        return obj;
      }
    }

    return null;
  }

  Future<bool> serveOrder(orderId) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'order/serveOrder/' + orderId.toString();

    var response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> dropOrder(orderId, reason) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'order/dropOrder/' + orderId.toString();

    var response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
      body: reason,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<BillResponse> getBill() async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'session/getBill/';
    url += await LocalStorage.getSessionFromStorage();
    // url += "22"; // for quick testing

    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      BillResponse obj = BillResponse.fromJson(response.body);
      if (obj != null) {
        return obj;
      }
    }

    return null;
  }

  Future<BillResponse> getBillBySessionNum(String sessionNum) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url =
        _baseUrl + 'session/getBillBySessionNum?sessionNum=' + sessionNum;
    if (sessionNum != null && sessionNum.trim().isNotEmpty) {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        BillResponse obj = BillResponse.fromJson(response.body);
        if (obj != null) {
          return obj;
        }
      }
    }

    return null;
  }

  Future<bool> changeStatusItem(int itemId, bool status) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'item/update/' + itemId.toString();

    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: json.encode({
        'isAvailable': status.toString(),
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateItem(int itemId, Item item) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'item/update/' + itemId.toString();

    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: json.encode({
        "description": item.description,
        "img": item.img,
        "isAvailable": item.available.toString(),
        "name": item.name,
        "price": item.price.toString()
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createItem(Item item) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'item/create';

    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: json.encode({
        "categoryId": 1,
        "description": item.description,
        "img": item.img,
        "isAvailable": item.available.toString(),
        "name": item.name,
        "price": item.price.toString()
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Account>> getAccount() async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'account/all';
    List<Account> result = [];

    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      for (var i = 0; i < jsonList.length; i++) {
        Account tmp = Account.fromJson(json.encode(jsonList[i]));
        result.add(tmp);
      }
      return result;
    }
    return List.empty();
  }

  Future<bool> changeStatusAccount(int accId, bool status) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'account/update/' + accId.toString();

    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: json.encode({
        "isActive": status.toString(),
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateAccount(int accId, Account acc) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'account/update/' + accId.toString();

    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: json.encode({
        "avatar": acc.avatar,
        "dob": acc.dob.toString().substring(0,10),
        "email": acc.email,
        "fullname": acc.fullname,
        "gender": acc.gender,
        "isActive": acc.active.toString(),
        "phone": acc.phone,
        "role": acc.role
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createAccount(Account acc, String password) async {
    String token = await LocalStorage.getAccessTokenFromStorage();
    String url = _baseUrl + 'account/create';

    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
      body: json.encode({
        "password": password,
        "avatar": acc.avatar,
        "dob": acc.dob.toString().substring(0,10),
        "email": acc.email,
        "fullname": acc.fullname,
        "gender": acc.gender,
        "isActive": acc.active.toString(),
        "phone": acc.phone,
        "role": acc.role
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
