import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kiennt_restaurant/models/api_response.dart';
import 'package:kiennt_restaurant/models/api_err.dart';
import 'package:kiennt_restaurant/models/auth.dart';
import 'package:kiennt_restaurant/models/user.dart';
import 'package:kiennt_restaurant/services/storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _baseUrl = "http://192.168.2.174:8091/";
Future<ApiResponse> authenticateUser(String email, String password) async {
  ApiResponse _apiResponse = new ApiResponse();

  try {
    final response = await http.post('${_baseUrl}auth/login',
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'email': email,
          'password': password,
        }));

    switch (response.statusCode) {
      case 200:
        _apiResponse.Data = User.fromJson(json.decode(response.body));

        Auth auth = Auth.fromJson(json.decode(response.body));

        int userId = auth.userid;
        String accessToken = auth.accessToken;
        String role = auth.role;

        await LocalStorage.saveUserInfo(userId, accessToken, role);

        break;
      case 401:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<void> logOut() async {
  await LocalStorage.deleteAllFromStorage();
}

Future<ApiResponse> getUserDetails(String userId) async {
  ApiResponse _apiResponse = new ApiResponse();
  try {
    final response = await http.get('${_baseUrl}account/$userId');

    switch (response.statusCode) {
      case 200:
        _apiResponse.Data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}
