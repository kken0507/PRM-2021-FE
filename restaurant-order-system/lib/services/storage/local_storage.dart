import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static Future saveUserInfo(int userId, String accessToken, String role) async {
    final storage = FlutterSecureStorage();

    await storage.write(key: 'userId', value: userId.toString());
    await storage.write(key: 'accessToken', value: accessToken);
    await storage.write(key: 'role', value: role);
  }

  static Future deleteUserInfo() async {
    final storage = FlutterSecureStorage();

    await storage.delete(key: 'userId');
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'role');
    await storage.delete(key: 'session');
  }

  static Future<String> getUserIdFromStorage() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'userId');
  }

  static Future<String> getAccessTokenFromStorage() async {
    final storage = FlutterSecureStorage();
    String token = await storage.read(key: 'accessToken');
    return token;
  }

  static Future deleteAllFromStorage() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  static Future<String> getRoleFromStorage() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'role');
  }

  static Future savePosition(String position) async {
    final storage = FlutterSecureStorage();

    await storage.write(key: 'position', value: position);
  }

  static Future deletePosition() async {
    final storage = FlutterSecureStorage();

    await storage.delete(key: 'position');
  }

  static Future<String> getPositionFromStorage() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'position');
  }

  static Future saveSession(String session) async {
    final storage = FlutterSecureStorage();

    await storage.write(key: 'session', value: session);
  }

  static Future deleteSesion() async {
    final storage = FlutterSecureStorage();

    await storage.delete(key: 'session');
  }

  static Future<String> getSessionFromStorage() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: 'session');
  }
}
