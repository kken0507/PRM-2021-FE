import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/configs/size_config.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/common/account.dart';
import 'package:kiennt_restaurant/screens/account_management/details/account_image.dart';
import 'package:kiennt_restaurant/screens/account_management/details/create_form.dart';
import 'package:kiennt_restaurant/screens/account_management/details/detail_form.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/util/my_util.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';
import 'package:kiennt_restaurant/widgets/navbar.dart';

class AccountDetailScreen extends StatefulWidget {
  static String routeName = "/account-detail";

  @override
  _AccountDetailScreenState createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _emailController = new TextEditingController();
  var _roleController = new TextEditingController();
  var _activeController = new TextEditingController();
  var _fullnameController = new TextEditingController();
  var _phoneController = new TextEditingController();
  var _genderController = new TextEditingController();
  var _dobController = new TextEditingController();
  var _passController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var img =
      "https://www.ncenet.com/wp-content/uploads/2020/04/No-image-found.jpg";
  Account acc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getThingsOnStartup(context);
    });
  }

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      if (acc != null) {
        acc.email = _emailController.text;
        acc.role = _roleController.text;
        acc.active = _activeController.text.toLowerCase() == "true";
        acc.fullname = _fullnameController.text;
        acc.phone = _phoneController.text;
        acc.gender = _genderController.text;
        acc.dob = DateTime.parse(_dobController.text);
        MyApi().updateAccount(acc.id, acc).then((value) => {
              if (value)
                {MyUtil.showSnackBar(context, 'Account updated')}
              else
                {MyUtil.showSnackBar(context, 'Update account failed')}
            });
      } else {
        Account newAcc = new Account(
            id: null,
            active: _activeController.text.toLowerCase() == "true",
            avatar:
                "https://st2.depositphotos.com/1009634/7235/v/600/depositphotos_72350117-stock-illustration-no-user-profile-picture-hand.jpg",
            dob: DateTime.parse(_dobController.text),
            email: _emailController.text,
            fullname: _fullnameController.text,
            gender: _genderController.text,
            phone: _phoneController.text,
            role: _roleController.text);
        MyApi().createAccount(newAcc, _passController.text).then((value) => {
              if (value)
                {
                  Navigator.pop(context),
                  MyUtil.showSnackBar(context, 'Account created')
                }
              else
                {MyUtil.showSnackBar(context, 'Create account failed')}
            });
      }
    } else {
      MyUtil.showSnackBar(context, 'Form is invalid');
    }
  }

  Future _getThingsOnStartup(context) async {
    acc = ModalRoute.of(context).settings.arguments;
    if (acc != null) {
      if (acc.email != null && acc.email.trim().isNotEmpty) {
        _emailController.text = acc.email;
      }
      if (acc.role != null && acc.role.trim().isNotEmpty) {
        _roleController.text = acc.role;
      }
      if (acc.active != null && acc.active.toString().trim().isNotEmpty) {
        _activeController.text = acc.active.toString();
      }
      if (acc.fullname != null && acc.fullname.trim().isNotEmpty) {
        _fullnameController.text = acc.fullname;
      }
      if (acc.phone != null && acc.phone.trim().isNotEmpty) {
        _phoneController.text = acc.phone;
      }
      if (acc.gender != null && acc.gender.trim().isNotEmpty) {
        _genderController.text = acc.gender;
      }
      if (acc.dob != null && acc.dob.toString().trim().isNotEmpty) {
        _dobController.text = acc.dob.toString().substring(0, 10);
      }
      if (acc.avatar != null && acc.avatar.trim().isNotEmpty) {
        setState(() {
          img = acc.avatar;
        });
      }
    } else {
      _roleController.text = "STAFF";
      _genderController.text = "M";
    }
  }

  body() {
    return ListView(shrinkWrap: true, children: [
      AccountImage(imgSrc: img),
      if (acc != null)
        DetailForm(
          emailController: _emailController,
          activeController: _activeController,
          dobController: _dobController,
          fullnameController: _fullnameController,
          genderController: _genderController,
          phoneController: _phoneController,
          roleController: _roleController,
          formKey: _formKey,
        ),
      if (acc == null)
        CreateForm(
          emailController: _emailController,
          activeController: _activeController,
          dobController: _dobController,
          fullnameController: _fullnameController,
          genderController: _genderController,
          phoneController: _phoneController,
          roleController: _roleController,
          passwordController: _passController,
          formKey: _formKey,
        ),
    ]);
  }

  bottom() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15.0),
        horizontal: getProportionateScreenWidth(30.0),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: getProportionateScreenWidth(190.0),
                child: DefaultButton(
                  color: ThemeColors.primary,
                  text: "Save",
                  press: () {
                    _handleSubmitted();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Navbar(
      title: "Detail",
      backButton: true,
      rightOptionCart: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      body: body(),
      bottomNavigationBar: bottom(),
    );
  }
}
