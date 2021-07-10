import 'package:flutter/material.dart';

import 'package:kiennt_restaurant/constants/Theme.dart';

//widgets
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:kiennt_restaurant/widgets/drawer.dart';
import 'package:kiennt_restaurant/widgets/input.dart';
import 'package:kiennt_restaurant/widgets/table-cell.dart';

class Elements extends StatefulWidget {
  @override
  _ElementsState createState() => _ElementsState();
}

class _ElementsState extends State<Elements> {
  bool switchValueOne;
  bool switchValueTwo;

  void initState() {
    setState(() {
      switchValueOne = true;
      switchValueTwo = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Elements",
        ),
        backgroundColor: ThemeColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Elements"),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
          child: SafeArea(
            bottom: true,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Buttons",
                      style: TextStyle(
                          color: ThemeColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 34.0, right: 34.0, top: 16),
                  child: RaisedButton(
                    textColor: ThemeColors.white,
                    color: ThemeColors.initial,
                    onPressed: () {
                      // Respond to button press
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("DEFAULT",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0))),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 34.0, right: 34.0, top: 8),
                  child: RaisedButton(
                    textColor: ThemeColors.text,
                    color: ThemeColors.secondary,
                    onPressed: () {
                      // Respond to button press
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("SECONDARY",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0))),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 34.0, right: 34.0, top: 8),
                  child: RaisedButton(
                    textColor: ThemeColors.white,
                    color: ThemeColors.primary,
                    onPressed: () {
                      // Respond to button press
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("PRIMARY",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0))),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 34.0, right: 34.0, top: 8),
                  child: RaisedButton(
                    textColor: ThemeColors.white,
                    color: ThemeColors.info,
                    onPressed: () {
                      // Respond to button press
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("INFO",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0))),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 34.0, right: 34.0, top: 8),
                  child: RaisedButton(
                    textColor: ThemeColors.white,
                    color: ThemeColors.success,
                    onPressed: () {
                      // Respond to button press
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("SUCCESS",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0))),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 34.0, right: 34.0, top: 8),
                  child: RaisedButton(
                    textColor: ThemeColors.white,
                    color: ThemeColors.warning,
                    onPressed: () {
                      // Respond to button press
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("WARNING",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0))),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 34.0, right: 34.0, top: 8),
                  child: RaisedButton(
                    textColor: ThemeColors.white,
                    color: ThemeColors.error,
                    onPressed: () {
                      // Respond to button press
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("ERROR",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Typography",
                      style: TextStyle(
                          color: ThemeColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Heading 1",
                      style: TextStyle(fontSize: 44, color: ThemeColors.text)),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Heading 2",
                    style: TextStyle(fontSize: 38, color: ThemeColors.text)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Heading 3",
                    style: TextStyle(fontSize: 30, color: ThemeColors.text)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Heading 4",
                    style: TextStyle(fontSize: 24, color: ThemeColors.text)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Heading 5",
                    style: TextStyle(fontSize: 21, color: ThemeColors.text)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Paragraph",
                    style: TextStyle(fontSize: 16, color: ThemeColors.text)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("This is a muted paragraph.",
                    style: TextStyle(fontSize: 16, color: ThemeColors.muted)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Inputs",
                      style: TextStyle(
                          color: ThemeColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Input(
                  placeholder: "Regular",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Input(
                  placeholder: "Custom border",
                  borderColor: ThemeColors.info,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Input(
                  placeholder: "Icon left",
                  prefixIcon: Icon(Icons.ac_unit),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Input(
                  placeholder: "Icon right",
                  suffixIcon: Icon(Icons.ac_unit),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Input(
                  placeholder: "Custom success",
                  borderColor: ThemeColors.success,
                  suffixIcon:
                      Icon(Icons.check_circle, color: ThemeColors.success),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Input(
                  placeholder: "Custom error",
                  borderColor: ThemeColors.error,
                  suffixIcon: Icon(Icons.error, color: ThemeColors.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 32, bottom: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Switches",
                      style: TextStyle(
                          color: ThemeColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Switch is ON",
                      style: TextStyle(color: ThemeColors.text)),
                  Switch.adaptive(
                    value: switchValueOne,
                    onChanged: (bool newValue) =>
                        setState(() => switchValueOne = newValue),
                    activeColor: ThemeColors.primary,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Switch is OFF",
                      style: TextStyle(color: ThemeColors.text)),
                  Switch.adaptive(
                    value: switchValueTwo,
                    onChanged: (bool newValue) =>
                        setState(() => switchValueTwo = newValue),
                    activeColor: ThemeColors.primary,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 32, bottom: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Navigation",
                      style: TextStyle(
                          color: ThemeColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              Navbar(
                title: "Regular",
                backButton: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Navbar(
                    title: "Custom background",
                    backButton: true,
                    bgColor: ThemeColors.primary),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Navbar(
                  title: "Categories",
                  searchBar: true,
                  categoryOne: "Incredible",
                  categoryTwo: "Customization",
                  backButton: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Navbar(
                  title: "Search",
                  searchBar: true,
                  backButton: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 32, bottom: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Table Cell",
                      style: TextStyle(
                          color: ThemeColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              TableCellSettings(
                  title: "Manage Options in Settings",
                  onTap: () {
                    Navigator.pushNamed(context, '/pro');
                  }),
            ]),
          ),
        )));
  }
}
