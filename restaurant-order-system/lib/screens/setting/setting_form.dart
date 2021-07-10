import 'package:flutter/material.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key key, this.controller, this.hintText}) : super(key: key);
  final TextEditingController controller;
  final String hintText;

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: widget.hintText ?? 'Enter a search term',
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          //   child: TextFormField(
          //     decoration: InputDecoration(
          //       border: UnderlineInputBorder(),
          //       labelText: 'Enter your username',
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
