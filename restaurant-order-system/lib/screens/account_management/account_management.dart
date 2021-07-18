import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/configs/size_config.dart';

import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/constants/my_const.dart';
import 'package:kiennt_restaurant/models/common/account.dart';
import 'package:kiennt_restaurant/screens/account_management/details/account_detail.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/util/my_util.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';

//widgets
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:kiennt_restaurant/widgets/drawer.dart';
import 'package:kiennt_restaurant/widgets/slidable_widget.dart';

class AccountManagementScreen extends StatefulWidget {
  static String routeName = "/account-management";

  @override
  _AccountManagementScreenState createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
// final GlobalKey _scaffoldKey = new GlobalKey();
  final TextEditingController _controller = new TextEditingController();
  String searchValue = "";
  List<Account> _list = [];
  List<Account> _listForDisplay = [];
  String _searchValue = "";

  @override
  void initState() {
    super.initState();
    initializeList();
  }

  Future<void> initializeList() async {
    _list = await MyApi().getAccount();
    if (_list.isNotEmpty) {
      setState(() {
        _listForDisplay = _list;
      });
    }
  }

  void _handleSearch(str) {
    _searchValue = str;
    _searchValue = _searchValue.toLowerCase();
    Set<Account> tmp = {};
    tmp.addAll(_list.where((account) {
      var s = account.fullname.toLowerCase();
      return s.contains(_searchValue);
    }).toList());
    tmp.addAll(_list.where((account) {
      var s = account.email.toLowerCase();
      return s.contains(_searchValue);
    }).toList());
    setState(() {
      _listForDisplay = tmp.toList();
    });
  }

  Future<void> _reloadList(str) async {
    _searchValue = str;
    _searchValue = _searchValue.toLowerCase();
    Set<Account> tmp = {};
    tmp.addAll(_list.where((account) {
      var s = account.fullname.toLowerCase();
      return s.contains(_searchValue);
    }).toList());
    tmp.addAll(_list.where((account) {
      var s = account.email.toLowerCase();
      return s.contains(_searchValue);
    }).toList());
    setState(() {
      _listForDisplay = tmp.toList();
    });
  }

  Future<void> pullRefresh() async {
    initializeList().then((value) => _reloadList(_searchValue));
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
                  text: "Create new",
                  press: () {
                    Navigator.pushNamed(
                      context,
                      AccountDetailScreen.routeName,
                    ).then((value) => initializeList()
                        .then((value) => _reloadList(_searchValue)));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: Navbar(
        title: "Account",
        searchBar: true,
        placeholder: "Search by fullname or email...",
        rightOptionCart: false,
        searchOnChanged: _handleSearch,
      ),
      backgroundColor: ThemeColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: ArgonDrawer(currentPage: "Account"),
      body: RefreshIndicator(
          onRefresh: pullRefresh,
          child: ListView.builder(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemBuilder: (context, index) {
              return SlidableWidget(
                child: _listItem(index),
                onDismissed: (action) =>
                    {dismissSlidableItem(context, index, action)},
              );
            },
            itemCount: _listForDisplay.length,
          )),
      bottomNavigationBar: bottom(),
    );
  }

  void dismissSlidableItem(
      BuildContext context, int index, SlidableAction action) {
    switch (action) {
      case SlidableAction.changeStatus:
        if (_listForDisplay[index].role !=
            MY_ROLES.MANAGER.toString().split(".").last) {
          MyApi()
              .changeStatusAccount(
                  _listForDisplay[index].id, !_listForDisplay[index].active)
              .then((value) => {
                    if (value)
                      {
                        initializeList().then((value) =>
                            _reloadList(_searchValue).then((value) =>
                                MyUtil.showSnackBar(
                                    context, 'Status changed'))),
                      }
                  });
        } else {
          MyUtil.showSnackBar(context, 'Can not change Manager\'s status');
        }
        break;
    }
  }

  _listItem(index) {
    return ThisCardItem(
      id: _listForDisplay[index].id,
      fullname: _listForDisplay[index].fullname,
      gender: _listForDisplay[index].gender,
      avatar: _listForDisplay[index].avatar,
      active: _listForDisplay[index].active,
      dob: _listForDisplay[index].dob,
      email: _listForDisplay[index].email,
      phone: _listForDisplay[index].phone,
      role: _listForDisplay[index].role,
      onTap: () {
        Navigator.pushNamed(context, AccountDetailScreen.routeName,
                arguments: _listForDisplay[index])
            .then((value) =>
                initializeList().then((value) => _reloadList(_searchValue)));
      },
    );
  }
}

class ThisCardItem extends StatelessWidget {
  ThisCardItem(
      {this.fullname = "Placeholder Title",
      this.gender = "M",
      this.email = "example@example.com",
      this.id = 0,
      this.avatar = "https://via.placeholder.com/200",
      this.active = true,
      this.role = "EXAMPLE",
      this.phone = "0909000333",
      this.dob,
      this.onTap = defaultFunc});

  final int id;
  final String email;
  final String role;
  final String phone;
  final String avatar;
  final String fullname;
  final String gender;
  final bool active;
  final DateTime dob;
  final Function onTap;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 0.6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0)),
                          image: DecorationImage(
                            image: NetworkImage(avatar),
                            fit: BoxFit.cover,
                          ))),
                ),
                Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID: " + id.toString(),
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 13)),
                          Text(fullname,
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 13)),
                          if(role != MY_ROLES.CUSTOMER.toString().split(".").last)Text("Gender: " + gender,
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 11)),
                          Text(email,
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 11)),
                          if(role != MY_ROLES.CUSTOMER.toString().split(".").last) Text(phone,
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 11)),
                          Text(role,
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 11)),
                          if(role != MY_ROLES.CUSTOMER.toString().split(".").last) Text("DOB: " + dob.toString().substring(0, 10),
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 11)),
                          Text(active ? "Active" : "Deactivated",
                              style: TextStyle(
                                  color: active
                                      ? ThemeColors.success
                                      : ThemeColors.error,
                                  fontSize: 11)),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
