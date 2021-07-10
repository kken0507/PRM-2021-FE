class Auth {
  int _userid;
  String _email;
  String _accessToken;
  String _role;

  // constructor
  Auth({String email, int userid, String accessToken, String role}) {
    this._userid = userid;
    this._email = email;
    this._accessToken = accessToken;
    this._role = role;
  }

  // Properties
  int get userid => _userid;
  set userid(int userid) => _userid = userid;
  String get email => _email;
  set email(String email) => _email = email;
  String get accessToken => _accessToken;
  set accessToken(String accessToken) => _accessToken = accessToken;
  String get role => _role;
  set role(String role) => _role = role;

  // create the user object from json input
  Auth.fromJson(Map<String, dynamic> json) {
    _email = json['email'];
    _userid = json['userId'];
    _accessToken = json['accessToken'];
    _role = json['role'];
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this._email;
    data['userId'] = this._userid;
    data['accessToken'] = this._accessToken;
    data['role'] = this._role;
    return data;
  }
}
