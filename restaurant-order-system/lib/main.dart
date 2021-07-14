import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/models/shopping_cart.dart';
import 'package:kiennt_restaurant/screens/account_management/account_management.dart';
import 'package:kiennt_restaurant/screens/account_management/details/account_detail.dart';
import 'package:kiennt_restaurant/screens/cart/cart_screen.dart';
import 'package:kiennt_restaurant/screens/checkout/after_checkout.dart';
import 'package:kiennt_restaurant/screens/checkout/checkout.dart';
import 'package:kiennt_restaurant/screens/checkout_staff_side/checkout_staff_side.dart';
import 'package:kiennt_restaurant/screens/confirmed_orders/component/confirmed_orders_in_session/component/detail/confirmed_order_detail.dart';
import 'package:kiennt_restaurant/screens/confirmed_orders/component/confirmed_orders_in_session/confirmed_orders_in_session.dart';
import 'package:kiennt_restaurant/screens/confirmed_orders/sessions_with_confirmed_orders.dart';
import 'package:kiennt_restaurant/screens/menu/details/item_detail.dart';
import 'package:kiennt_restaurant/screens/menu/dispatcher.dart';
import 'package:kiennt_restaurant/screens/menu/start_session.dart';
import 'package:kiennt_restaurant/screens/menu_staff_side/details/item_detail.dart';
import 'package:kiennt_restaurant/screens/menu_staff_side/menu_staff_side.dart';

// screens
import 'package:kiennt_restaurant/screens/onboarding.dart';
import 'package:kiennt_restaurant/screens/order_history/component/detail/order_detail.dart';
import 'package:kiennt_restaurant/screens/order_history/order_history.dart';
import 'package:kiennt_restaurant/screens/pending_orders/component/pending_orders_in_session/component/detail/pending_order_detail.dart';
import 'package:kiennt_restaurant/screens/pending_orders/component/pending_orders_in_session/pending_orders_in_session.dart';
import 'package:kiennt_restaurant/screens/pending_orders/sessions_with_pending_orders.dart';
import 'package:kiennt_restaurant/screens/home.dart';
import 'package:kiennt_restaurant/screens/profile.dart';
import 'package:kiennt_restaurant/screens/articles.dart';
import 'package:kiennt_restaurant/screens/elements.dart';
import 'package:kiennt_restaurant/screens/login.dart';
import 'package:kiennt_restaurant/landing.dart';
import 'package:kiennt_restaurant/screens/menu/menu.dart';
import 'package:kiennt_restaurant/screens/setting/setting.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShoppingCart(),
        )
      ],
      child: MaterialApp(
          title: 'Restaurant',
          theme: ThemeData(fontFamily: 'OpenSans'),
          initialRoute: Landing.routeName,
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            "/onboarding": (BuildContext context) => new Onboarding(),
            // "/home": (BuildContext context) => new Home(),
            "/profile": (BuildContext context) => new Profile(),
            "/articles": (BuildContext context) => new Articles(),
            "/elements": (BuildContext context) => new Elements(),
            // "/account": (BuildContext context) => new Register(),
            // "/pro": (BuildContext context) => new Pro(),
            Login.routeName: (BuildContext context) => new Login(),
            MenuDispatcher.routeName: (BuildContext context) => new MenuDispatcher(),
            MenuScreen.routeName: (BuildContext context) => new MenuScreen(),
            StartSessionScreen.routeName: (BuildContext context) =>
                new StartSessionScreen(),
            Landing.routeName: (BuildContext context) => new Landing(),
            ItemDetail.routeName: (BuildContext context) => new ItemDetail(),
            CartScreen.routeName: (BuildContext context) => CartScreen(),
            SettingScreen.routeName: (BuildContext context) => SettingScreen(),
            OrderHistoryScreen.routeName: (BuildContext context) =>
                OrderHistoryScreen(),
            OrderDetailScreen.routeName: (BuildContext context) =>
                OrderDetailScreen(),
            PendingOrdersScreen.routeName: (BuildContext context) =>
                PendingOrdersScreen(),
            PendingOrdersInASessionScreen.routeName: (BuildContext context) =>
                PendingOrdersInASessionScreen(),
            PendingOrderDetailScreen.routeName: (BuildContext context) =>
                PendingOrderDetailScreen(),
            ConfirmedOrdersScreen.routeName: (BuildContext context) =>
                ConfirmedOrdersScreen(),
            ConfirmedOrdersInASessionScreen.routeName: (BuildContext context) =>
                ConfirmedOrdersInASessionScreen(),
            ConfirmedOrderDetailScreen.routeName: (BuildContext context) =>
                ConfirmedOrderDetailScreen(),
            CheckoutScreen.routeName: (BuildContext context) =>
                CheckoutScreen(),
            AfterCheckoutScreen.routeName: (BuildContext context) =>
                AfterCheckoutScreen(),
            CheckoutStaffScreen.routeName: (BuildContext context) => CheckoutStaffScreen(),
            MenuStaffSideScreen.routeName: (BuildContext context) => MenuStaffSideScreen(),
            ItemDetailStaffScreen.routeName: (BuildContext context) => ItemDetailStaffScreen(),
            AccountManagementScreen.routeName: (BuildContext context) => AccountManagementScreen(),
            AccountDetailScreen.routeName: (BuildContext context) => AccountDetailScreen(),
          }),
    );
  }
}
