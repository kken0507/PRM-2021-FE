class ApiError {
  String _error;
  String _message;

  ApiError({String error, String message}) {
    this._error = error;
    this._message = message;
  }

  String get error => _error;
  set error(String error) => _error = error;
  String get message => _message;
  set message(String message) => _message = message;

  ApiError.fromJson(Map<String, dynamic> json) {
    _error = json['error'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this._error;
    data['message'] = this._message;
    return data;
  }
}