import 'package:flutter/material.dart';

class DetailForm extends StatefulWidget {
  const DetailForm(
      {Key key,
      this.nameController,
      this.desController,
      this.priceController,
      this.formKey,
      this.statusController})
      : super(key: key);
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController desController;
  final TextEditingController statusController;
  final GlobalKey<FormState> formKey;

  @override
  _DetailFormState createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  bool _flag = false;

  void _handleCheckbox(bool e) {
    setState(() {
      _flag = e;
      widget.statusController.text = _flag.toString();
    });
  }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _flag = widget.statusController.text.toLowerCase() == "true";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: widget.nameController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Name:',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty value";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: widget.priceController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Price:',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty value";
                    }
                    return null;
                  },
                  controller: widget.desController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Description:',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: CheckboxListTile(
                  title: Text("Available"),
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
