class LoginUser {
  /*
  This class encapsulates the json response from the api
  {
      'password': '4123',
      'email': 'x7uytx@mundanecode.com'
  }
  */
  String _password;
  String _email;

  // constructor
  LoginUser({String password, String email}) {
    this._password = password;
    this._email = email;
  }

  // Properties
  String get password => _password;
  set password(String password) => _password = password;
  String get email => _email;
  set email(String email) => _email = email;

  // create the user object from json input
  LoginUser.fromJson(Map<String, dynamic> json) {
    _password = json['password'];
    _email = json['email'];
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this._password;
    data['email'] = this._email;
    return data;
  }
}
