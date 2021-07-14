import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/my_const.dart';
import 'package:kiennt_restaurant/util/my_util.dart';

class DetailForm extends StatefulWidget {
  const DetailForm({
    Key key,
    this.emailController,
    this.roleController,
    this.activeController,
    this.fullnameController,
    this.phoneController,
    this.genderController,
    this.dobController,
    this.passwordController,
    this.formKey,
  }) : super(key: key);
  final TextEditingController emailController;
  final TextEditingController roleController;
  final TextEditingController activeController;
  final TextEditingController fullnameController;
  final TextEditingController phoneController;
  final TextEditingController genderController;
  final TextEditingController dobController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  _DetailFormState createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  bool _flag = false;
  var _currentSelectedGender = MyConst.genders[0];
  var _currentSelectedRole = MyConst.roles[1];

  void _handleCheckbox(bool e) {
    if (_currentSelectedRole != MY_ROLES.MANAGER.toString().split('.').last) {
      setState(() {
        _flag = e;
        widget.activeController.text = _flag.toString();
      });
    } else {
      MyUtil.showSnackBar(context, "Can not change Manager's status");
    }
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _flag = widget.activeController.text.toLowerCase() == "true";
        _currentSelectedGender = widget.genderController.text;
        _currentSelectedRole = widget.roleController.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _genders = MyConst.genders;
    var _roles = MyConst.roles.sublist(1, 3);

    return Container(
      child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty value";
                    }
                    return null;
                  },
                  controller: widget.fullnameController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Fullname:',
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              //   child: TextFormField(
              //     validator: (value) {
              //       if (value.isEmpty) {
              //         return "Empty value";
              //       }
              //       return null;
              //     },
              //     readOnly: true,
              //     controller: widget.genderController,
              //     decoration: InputDecoration(
              //       border: UnderlineInputBorder(),
              //       labelText: 'Gender:',
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        // labelStyle: TextStyle(
                        //     color: Colors.redAccent, fontSize: 20.0),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        labelText: 'Gender:',
                        hintText: 'Please select...',
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(5.0))
                        border: UnderlineInputBorder(),
                      ),
                      isEmpty: _currentSelectedGender == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelectedGender,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _currentSelectedGender = newValue;
                              widget.genderController.text = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _genders.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  validator: (value) {
                    Pattern pattern1 =
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                    RegExp regex1 = new RegExp(pattern1);
                    if (value.isEmpty) {
                      return "Empty value";
                    }
                    if (!regex1.hasMatch(value)) {
                      return 'Invalid Format';
                    }
                    return null;
                  },
                  controller: widget.emailController,
                  maxLines: null,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Email:',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  validator: (value) {
                    Pattern pattern = r'^(?:[+0]9)?[0-9]{10}$';
                    // Pattern pattern =
                    //     r'/^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im';
                    RegExp regex = new RegExp(pattern);
                    if (value.isEmpty) {
                      return "Empty value";
                    }
                    if (value.length != 10) {
                      return "Phone number must be 10 digits";
                    }
                    if (!regex.hasMatch(value)) {
                      return 'Invalid Format';
                    }
                    return null;
                  },
                  controller: widget.phoneController,
                  maxLines: null,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Phone:',
                  ),
                ),
              ),
              if (!(_currentSelectedRole !=
                  MY_ROLES.MANAGER.toString().split('.').last))
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Empty value";
                      }
                      return null;
                    },
                    controller: widget.roleController,
                    readOnly: widget.roleController.text ==
                        MY_ROLES.MANAGER.toString().split('.').last,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Role:',
                    ),
                  ),
                ),
              if (_currentSelectedRole !=
                  MY_ROLES.MANAGER.toString().split('.').last)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          // labelStyle: TextStyle(
                          //     color: Colors.redAccent, fontSize: 20.0),
                          errorStyle: TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          labelText: 'Role:',
                          hintText: 'Please select...',
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(5.0))
                          border: UnderlineInputBorder(),
                        ),
                        isEmpty: _currentSelectedRole == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _currentSelectedRole,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _currentSelectedRole = newValue;
                                widget.roleController.text = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _roles.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty value";
                    }
                    if (DateTime.parse(value).isAfter(DateTime.now())) {
                      return "Can not set future date";
                    }
                    if (DateTime.now()
                            .difference(DateTime.parse(value))
                            .inDays <=
                        6570) {
                      return "Age must over 18";
                    }
                    if (!MyUtil().isValidDate(value)) {
                      return "Value not valid";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.datetime,
                  controller: widget.dobController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Date of birth:',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: CheckboxListTile(
                  title: Text("Active"),
                  value: _flag,
                  onChanged: _handleCheckbox,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ],
          )),
    );
  }
}
