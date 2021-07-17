import 'dart:async';

import 'package:flutter/material.dart';

import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/item.dart';
import 'package:kiennt_restaurant/screens/menu/details/item_detail.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/widgets/card-item.dart';

//widgets
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:kiennt_restaurant/widgets/drawer.dart';

// class Menu extends StatelessWidget {
//   // final GlobalKey _scaffoldKey = new GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: Navbar(
//           title: "Menu",
//           searchBar: true,
//         ),
//         backgroundColor: ThemeColors.bgColorScreen,
//         // key: _scaffoldKey,
//         drawer: ArgonDrawer(currentPage: "Menu"),
//         body: Container(
//           padding: EdgeInsets.only(left: 24.0, right: 24.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16.0),
//                   child: CardItem(
//                       cta: "Press to view detail...",
//                       title: "Title here",
//                       description: "description",
//                       img: "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80",
//                       onTap: () {
//                         Navigator.pushNamed(context, '/item-detail', arguments: Item(id: 1,name: "Test name", description: "description", img: "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80", price: 1200, available: true));
//                       }),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

// class Menu extends StatelessWidget {
//   // final GlobalKey _scaffoldKey = new GlobalKey();
//   String searchValue = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: Navbar(
//           title: "Menu",
//           searchBar: true,
//           searchOnChanged: (str) {
//             this.searchValue = str;
//           },
//         ),
//         backgroundColor: ThemeColors.bgColorScreen,
//         // key: _scaffoldKey,
//         drawer: ArgonDrawer(currentPage: "Menu"),
//         body: FutureBuilder<List>(
//           future: MyApi().getItems(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting)
//               return LinearProgressIndicator();
//             if (snapshot.hasData) {
//               if (snapshot.data != null) {
//                 return ListView.builder(
//                   physics: BouncingScrollPhysics(),
//                   scrollDirection: Axis.vertical,
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (context, index) {
//                     return CardItem(
//                         cta: "Press to view detail...",
//                         title: (snapshot.data[index] as Item).name,
//                         description: (snapshot.data[index] as Item).description,
//                         price: (snapshot.data[index] as Item).price,
//                         img:
//                             (snapshot.data[index] as Item).img,
//                         onTap: () {
//                           Navigator.pushNamed(context, '/item-detail',
//                               arguments: (snapshot.data[index] as Item));
//                         });
//                   },
//                 );
//               }

//               if (snapshot.data.isEmpty)
//                 return Center(
//                   child: Text('Empty'),
//                 );
//             }
//             return Center(
//               child: Text('Error, try again!'),
//             );
//           },
//         ));
//   }
// }

class MenuScreen extends StatefulWidget {
  static String routeName = "/menu-screen";

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
// final GlobalKey _scaffoldKey = new GlobalKey();
  final TextEditingController _controller = new TextEditingController();
  String _searchValue = "";
  List<Item> _list = [];
  List<Item> _listForDisplay = [];

  @override
  void initState() {
    super.initState();
    initializeList();
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

  Future<void> initializeList() async {
    _list = await MyApi().searchItems(null, "true");
    if (_list.isNotEmpty) {
      setState(() {
        _listForDisplay = _list;
      });
    }
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

  FutureOr onGoBack(dynamic value) {
    initializeList().then((value) => _reloadList(_searchValue));
  }

  Future<void> pullRefresh() async {
    initializeList().then((value) => _reloadList(_searchValue));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Menu",
          searchBar: true,
          placeholder: "Search by name...",
          searchOnChanged: _handleSearch,
        ),
        backgroundColor: ThemeColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: ArgonDrawer(currentPage: "Menu"),
        body: RefreshIndicator(
            onRefresh: pullRefresh,
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemBuilder: (context, index) {
                return _listItem(index);
              },
              itemCount: _listForDisplay.length,
            )));
  }

  _listItem(index) {
    return CardItem(
        cta: "Press to view detail...",
        title: _listForDisplay[index].name,
        description: _listForDisplay[index].description,
        img: _listForDisplay[index].img,
        price: _listForDisplay[index].price,
        onTap: () {
          Navigator.pushNamed(context, ItemDetail.routeName,
                  arguments: Item(
                      id: _listForDisplay[index].id,
                      name: _listForDisplay[index].name,
                      description: _listForDisplay[index].description,
                      img: _listForDisplay[index].img,
                      price: _listForDisplay[index].price,
                      available: _listForDisplay[index].available))
              .then(onGoBack);
        });
  }
}
