import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/configs/size_config.dart';

import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/constants/my_const.dart';
import 'package:kiennt_restaurant/models/item.dart';
import 'package:kiennt_restaurant/screens/menu_staff_side/details/item_detail.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/services/storage/local_storage.dart';
import 'package:kiennt_restaurant/util/my_util.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';

//widgets
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:kiennt_restaurant/widgets/drawer.dart';
import 'package:kiennt_restaurant/widgets/slidable_widget.dart';

class MenuStaffSideScreen extends StatefulWidget {
  static String routeName = "/menu-staff-screen";

  @override
  _MenuStaffSideScreenState createState() => _MenuStaffSideScreenState();
}

class _MenuStaffSideScreenState extends State<MenuStaffSideScreen> {
// final GlobalKey _scaffoldKey = new GlobalKey();
  final TextEditingController _controller = new TextEditingController();
  String _searchValue = "";
  List<Item> _list = [];
  List<Item> _listForDisplay = [];
  String _curRole;

  @override
  void initState() {
    super.initState();
    initializeList();
    getRole();
  }

  Future<void> getRole() async {
    String s = await LocalStorage.getRoleFromStorage();
    if (s != null) {
      setState(() {
        _curRole = s;
      });
    }
  }

  Future<void> initializeList() async {
    _list = await MyApi().getItems();
    if (_list.isNotEmpty) {
      setState(() {
        _listForDisplay = _list;
      });
    }
  }

  void _handleSearch(str) {
    _searchValue = str;
    _searchValue = _searchValue.toLowerCase();
    setState(() {
      _listForDisplay = _list.where((item) {
        var title = item.name.toLowerCase();
        return title.contains(_searchValue);
      }).toList();
    });
  }

  Future<void> _reloadList(str) async {
    _searchValue = str;
    _searchValue = _searchValue.toLowerCase();
    setState(() {
      _listForDisplay = _list.where((item) {
        var title = item.name.toLowerCase();
        return title.contains(_searchValue);
      }).toList();
    });
  }

  bottom() {
    if (_curRole == MY_ROLES.MANAGER.toString().split(".").last)
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
                        ItemDetailStaffScreen.routeName,
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
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: Navbar(
        title: "Menu",
        searchBar: true,
        placeholder: "Search by name...",
        rightOptionCart: false,
        searchOnChanged: _handleSearch,
      ),
      backgroundColor: ThemeColors.bgColorScreen,
      // key: _scaffoldKey,
      drawer: ArgonDrawer(currentPage: "Menu"),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return SlidableWidget(
            child: _listItem(index),
            onDismissed: (action) =>
                {dismissSlidableItem(context, index, action)},
          );
        },
        itemCount: _listForDisplay.length,
      ),
      bottomNavigationBar: bottom(),
    );
  }

  void dismissSlidableItem(
      BuildContext context, int index, SlidableAction action) {
    switch (action) {
      case SlidableAction.changeStatus:
        MyApi()
            .changeStatusItem(
                _listForDisplay[index].id, !_listForDisplay[index].available)
            .then((value) => {
                  if (value)
                    {
                      initializeList().then((value) => _reloadList(_searchValue)
                          .then((value) =>
                              MyUtil.showSnackBar(context, 'Status changed'))),
                    }
                });
        break;
    }
  }

  _listItem(index) {
    return ThisCardItem(
      id: _listForDisplay[index].id,
      name: _listForDisplay[index].name,
      description: _listForDisplay[index].description,
      img: _listForDisplay[index].img,
      price: _listForDisplay[index].price,
      available: _listForDisplay[index].available,
      onTap: () {
        if (_curRole == MY_ROLES.MANAGER.toString().split(".").last) {
          Navigator.pushNamed(context, ItemDetailStaffScreen.routeName,
                  arguments: Item(
                      id: _listForDisplay[index].id,
                      name: _listForDisplay[index].name,
                      description: _listForDisplay[index].description,
                      img: _listForDisplay[index].img,
                      price: _listForDisplay[index].price,
                      available: _listForDisplay[index].available))
              .then((value) =>
                  initializeList().then((value) => _reloadList(_searchValue)));
        }
      },
    );
  }
}

class ThisCardItem extends StatelessWidget {
  ThisCardItem(
      {this.name = "Placeholder Title",
      this.description = "",
      this.price = 0,
      this.id = 0,
      this.img = "https://via.placeholder.com/200",
      this.available = true,
      this.onTap = defaultFunc});

  final int id;
  final String img;
  final Function onTap;
  final String name;
  final String description;
  final double price;
  final bool available;

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
                            image: NetworkImage(img),
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
                          Text(name,
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 13)),
                          Text("[" + description + "]",
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 11)),
                          Text(price.toString() + "VND",
                              style: TextStyle(
                                  color: ThemeColors.header, fontSize: 11)),
                          Text(available ? "Available" : "Not available",
                              style: TextStyle(
                                  color: available
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
