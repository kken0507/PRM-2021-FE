import 'dart:io';

import 'package:kiennt_restaurant/screens/menu_staff_side/details/item_image.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DetailForm extends StatefulWidget {
  const DetailForm({
    Key key,
    this.nameController,
    this.desController,
    this.priceController,
    this.formKey,
    this.statusController,
    this.imageController,
  }) : super(key: key);
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController desController;
  final TextEditingController statusController;
  final TextEditingController imageController;
  final GlobalKey<FormState> formKey;

  @override
  _DetailFormState createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  bool _flag = false;
  File _imageFile;

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

  Future pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    widget.imageController.text = await taskSnapshot.ref.getDownloadURL();
    setState(() {});
  }

  Future deleteImage() async {
    setState(() {
      widget.imageController.text = "";
    });
  }

  Future<String> fetchStr() async {
    if (widget.imageController.text == "")
      return Future.delayed(
          Duration(seconds: 3), () => widget.imageController.text);
    return widget.imageController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder<String>(
                future: fetchStr(),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    // case ConnectionState.none:
                    //   return Text('Press button to start.');
                    // case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else if (snapshot.hasData)
                        return ItemImage(imgSrc: widget.imageController.text);
                    // else
                    //   return Text('Press button to start.');
                  }
                  return Text('Something wrong'); // unreachable
                },
              ),
              // ItemImage(imgSrc: widget.imageController.text),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: DefaultButton(
                  color: ThemeColors.info,
                  text: "Change Image",
                  press: () async {
                    pickImage().then((value) => deleteImage()
                        .then((value) => uploadImageToFirebase(context)));
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
                    var validCharacters = RegExp(r'^[0-9]+[.]?[0-9]+$');
                    if (value.isEmpty) {
                      return "Empty value";
                    }
                    if (!validCharacters.hasMatch(value)) {
                      return "Only number allowed";
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
