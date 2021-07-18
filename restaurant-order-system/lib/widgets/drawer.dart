import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/constants/my_const.dart';
import 'package:kiennt_restaurant/models/response/session.dart';
import 'package:kiennt_restaurant/screens/account_management/account_management.dart';
import 'package:kiennt_restaurant/screens/checkout/checkout.dart';
import 'package:kiennt_restaurant/screens/checkout_staff_side/checkout_staff_side.dart';
import 'package:kiennt_restaurant/screens/confirmed_orders/sessions_with_confirmed_orders.dart';
import 'package:kiennt_restaurant/screens/login.dart';
import 'package:kiennt_restaurant/screens/menu/dispatcher.dart';
import 'package:kiennt_restaurant/screens/menu_staff_side/menu_staff_side.dart';
import 'package:kiennt_restaurant/screens/order_history/order_history.dart';
import 'package:kiennt_restaurant/screens/pending_orders/sessions_with_pending_orders.dart';
import 'package:kiennt_restaurant/screens/setting/setting.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/services/storage/local_storage.dart';
import 'package:kiennt_restaurant/util/my_util.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'package:kiennt_restaurant/constants/Theme.dart';

import 'package:kiennt_restaurant/widgets/drawer-tile.dart';

class ArgonDrawer extends StatelessWidget {
  final String currentPage;

  ArgonDrawer({this.currentPage});

  // _launchURL() async {
  //   const url = 'https://example.com';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  Widget _buildChildFuture(context, curPage, routeName, icon, future) {
    return FutureBuilder(
      future: future ?? LocalStorage.getSessionFromStorage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DrawerTile(
              icon: icon ?? Icons.history,
              onTap: () {
                if (currentPage != curPage ?? "History")
                  Navigator.pushReplacementNamed(
                      context, routeName ?? OrderHistoryScreen.routeName);
              },
              iconColor: ThemeColors.primary,
              title: curPage ?? "History",
              isSelected: currentPage == (curPage ?? "History") ? true : false);
        }
        return Container();
      },
    );
  }

  Widget _buildChild(context, btnTitle, routeName, icon) {
    return DrawerTile(
        icon: icon ?? Icons.history,
        onTap: () {
          if (currentPage != btnTitle ?? "History")
            Navigator.pushReplacementNamed(
                context, routeName ?? OrderHistoryScreen.routeName);
        },
        iconColor: ThemeColors.primary,
        title: btnTitle ?? "History",
        isSelected: currentPage == (btnTitle ?? "History") ? true : false);
  }

  // Widget _buildFunctionalChildFuture(
  //     context, btnTitle, icon, Function onTap, future) {
  //   return FutureBuilder(
  //     future: future ?? LocalStorage.getSessionFromStorage(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return DrawerTile(
  //             icon: icon ?? Icons.logout,
  //             onTap: onTap ??
  //                 () async {
  //                   LocalStorage.deleteUserInfo();
  //                   Navigator.pushNamedAndRemoveUntil(
  //                       context, '/login', ModalRoute.withName('/login'));
  //                 },
  //             iconColor: ThemeColors.muted,
  //             title: btnTitle ?? "Logout",
  //             isSelected: currentPage == (btnTitle ?? "Logout") ? true : false);
  //       } else {
  //         return Container();
  //       }
  //     },
  //   );
  // }

  Widget _buildFunctionalChild(context, btnTitle, icon, Function onTap) {
    return DrawerTile(
        icon: icon ?? Icons.logout,
        onTap: onTap ??
            () async {
              var sessionId = await LocalStorage.getSessionFromStorage();
              SessionResponse session;
              if (sessionId != null)
                session = await MyApi().getSessionById(int.parse(sessionId));

              if (session != null && session.status != "COMPLETED") {
                Navigator.pop(context);
                MyUtil.showSnackBar(context, "Session is not completed");
              }

              if (session == null ||
                  (session != null && session.status == "COMPLETED")) {
                await LocalStorage.deleteUserInfo();
                Navigator.pushNamedAndRemoveUntil(context, Login.routeName,
                    ModalRoute.withName(Login.routeName));
              }
            },
        iconColor: ThemeColors.muted,
        title: btnTitle ?? "Logout",
        isSelected: currentPage == (btnTitle ?? "Logout") ? true : false);
  }

  Widget _buildChildRole(child, roles) {
    return FutureBuilder(
      future: LocalStorage.getRoleFromStorage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if ((roles as List).contains(snapshot.data)) return child;
        }
        return Container();
      },
    );
  }

  Widget _buildListViewRole(children, roles) {
    return FutureBuilder(
      future: LocalStorage.getRoleFromStorage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if ((roles as List).contains(snapshot.data))
            return Expanded(
                flex: 2,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: children,
                ));
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var roleList1 = <String>[MY_ROLES.STAFF.toString().split('.').last];
    var roleList2 = <String>[MY_ROLES.CUSTOMER.toString().split('.').last];
    var roleList3 = <String>[MY_ROLES.MANAGER.toString().split('.').last];

    var contentStaffList = <Widget>[
      _buildChild(context, "Pending", PendingOrdersScreen.routeName,
          Icons.hourglass_bottom),
      _buildChild(context, "Confirmed", ConfirmedOrdersScreen.routeName,
          Icons.check_rounded),
      _buildChild(context, "Checkout Staff", CheckoutStaffScreen.routeName,
          Icons.camera),
      _buildChild(
          context, "Menu", MenuStaffSideScreen.routeName, Icons.menu_book),
    ];

    var contentCustomerList = <Widget>[
      _buildChild(context, "Menu", MenuDispatcher.routeName, Icons.menu_book),
      _buildChildFuture(
        context,
        "History",
        OrderHistoryScreen.routeName,
        Icons.history,
        LocalStorage.getSessionFromStorage(),
      ),
      _buildChildFuture(
          context,
          "Checkout",
          CheckoutScreen.routeName,
          Icons.assignment_returned_outlined,
          LocalStorage.getSessionFromStorage()),
    ];

    var contentManagerList = <Widget>[
      _buildChild(context, "Pending", PendingOrdersScreen.routeName,
          Icons.hourglass_bottom),
      _buildChild(context, "Confirmed", ConfirmedOrdersScreen.routeName,
          Icons.check_rounded),
      _buildChild(context, "Checkout Staff", CheckoutStaffScreen.routeName,
          Icons.camera),
      _buildChild(
          context, "Menu", MenuStaffSideScreen.routeName, Icons.menu_book),
      _buildChild(
          context, "Account", AccountManagementScreen.routeName, Icons.person),
    ];

    return Drawer(
        child: Container(
      color: ThemeColors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  // child: Image.asset("assets/img/argon-logo.png"),
                  child: Image.asset("assets/images/ueat-2.png"),
                ),
              ),
            )),
        // Expanded(
        //   flex: 2,
        //   child: ListView(
        //     padding: EdgeInsets.only(top: 24, left: 16, right: 16),
        //     children: [
        //       // DrawerTile(
        //       //     icon: Icons.home,
        //       //     onTap: () {
        //       //       if (currentPage != "Home")
        //       //         Navigator.pushReplacementNamed(context, '/home');
        //       //     },
        //       //     iconColor: ThemeColors.primary,
        //       //     title: "Home",
        //       //     isSelected: currentPage == "Home" ? true : false),
        //       // DrawerTile(
        //       //     icon: Icons.pie_chart,
        //       //     onTap: () {
        //       //       if (currentPage != "Profile")
        //       //         Navigator.pushReplacementNamed(context, '/profile');
        //       //     },
        //       //     iconColor: ThemeColors.warning,
        //       //     title: "Profile",
        //       //     isSelected: currentPage == "Profile" ? true : false),
        //       // DrawerTile(
        //       //     icon: Icons.account_circle,
        //       //     onTap: () {
        //       //       if (currentPage != "Account")
        //       //         Navigator.pushReplacementNamed(context, '/account');
        //       //     },
        //       //     iconColor: ThemeColors.info,
        //       //     title: "Account",
        //       //     isSelected: currentPage == "Account" ? true : false),
        //       // DrawerTile(
        //       //     icon: Icons.settings_input_component,
        //       //     onTap: () {
        //       //       if (currentPage != "Elements")
        //       //         Navigator.pushReplacementNamed(context, '/elements');
        //       //     },
        //       //     iconColor: ThemeColors.error,
        //       //     title: "Elements",
        //       //     isSelected: currentPage == "Elements" ? true : false),
        //       // DrawerTile(
        //       //     icon: Icons.apps,
        //       //     onTap: () {
        //       //       if (currentPage != "Articles")
        //       //         Navigator.pushReplacementNamed(context, '/articles');
        //       //     },
        //       //     iconColor: ThemeColors.primary,
        //       //     title: "Articles",
        //       //     isSelected: currentPage == "Articles" ? true : false),

        //       _buildChild(context, "Menu", '/menu', Icons.menu_book),
        //       _buildChildFuture(
        //         context,
        //         "History",
        //         OrderHistoryScreen.routeName,
        //         Icons.history,
        //         LocalStorage.getSessionFromStorage(),
        //       ),
        //       _buildChildFuture(
        //           context,
        //           "Checkout",
        //           CheckoutScreen.routeName,
        //           Icons.assignment_returned_outlined,
        //           LocalStorage.getSessionFromStorage()),

        //       // _buildChild(context, "Pending", PendingOrdersScreen.routeName,
        //       //     Icons.hourglass_bottom),
        //       // _buildChild(context, "Confirmed", ConfirmedOrdersScreen.routeName,
        //       //     Icons.check_rounded),
        //       // _buildChild(context, "Checkout Staff",
        //       //     CheckoutStaffScreen.routeName, Icons.camera),

        //       // _buildChildRole(_buildChild(context, "Pending", PendingOrdersScreen.routeName,
        //       // Icons.hourglass_bottom), "STAFF")
        //     ],
        //   ),
        // ),
        _buildListViewRole(contentStaffList, roleList1),
        _buildListViewRole(contentCustomerList, roleList2),
        _buildListViewRole(contentManagerList, roleList3),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: ThemeColors.muted),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                  //   child: Text("DOCUMENTATION",
                  //       style: TextStyle(
                  //         color: Color.fromRGBO(0, 0, 0, 0.5),
                  //         fontSize: 15,
                  //       )),
                  // ),
                  // DrawerTile(
                  //     icon: Icons.airplanemode_active,
                  //     onTap: _launchURL,
                  //     iconColor: ThemeColors.muted,
                  //     title: "Getting Started",
                  //     isSelected:
                  //         currentPage == "Getting started" ? true : false),
                  _buildFunctionalChild(context, null, null, null),

                  _buildChildRole(
                      _buildFunctionalChild(context, "Setting", Icons.settings,
                          () async {
                        Navigator.pushNamed(context, SettingScreen.routeName);
                      }),
                      roleList2)
                ],
              )),
        ),
      ]),
    ));
  }
}
