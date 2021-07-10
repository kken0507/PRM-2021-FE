class User {
  /*
  This class encapsulates the json response from the api
  {
      'fullname': 'Peter Clarke',
      'email': 'x7uytx@mundanecode.com'
  }
  */
  // String _fullname;
  int _userid;
  String _email;

  // constructor
  User({
    // String fullname,
     String email, int userid}) {
    // this._fullname = fullname;
    this._userid = userid;
    this._email = email;
  }

  // Properties
  // String get fullname => _fullname;
  // set fullname(String fullname) => _fullname = fullname;
    int get userid => _userid;
  set userid(int userid) => _userid = userid;
  String get email => _email;
  set email(String email) => _email = email;

  // create the user object from json input
  User.fromJson(Map<String, dynamic> json) {
    // _fullname = json['fullname'];
    _email = json['email'];
    _userid = json['userId'];
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['fullname'] = this._fullname;
    data['email'] = this._email;
    data['userId'] = this._userid;
    return data;
  }
}
