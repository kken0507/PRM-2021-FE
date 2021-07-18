import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/configs/size_config.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/item.dart';
import 'package:kiennt_restaurant/screens/menu_staff_side/details/detail_form.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/util/my_util.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';
import 'package:kiennt_restaurant/widgets/navbar.dart';

class ItemDetailStaffScreen extends StatefulWidget {
  static String routeName = "/item-detail-staff";

  // final Item item;

  // const ItemDetailStaffScreen ({ Key key, this.item }): super(key: key);

  @override
  _ItemDetailStaffScreenState createState() => _ItemDetailStaffScreenState();
}

class _ItemDetailStaffScreenState extends State<ItemDetailStaffScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _nameController = TextEditingController();
  var _priceController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _statusController = TextEditingController();
  var _imageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var img =
      "https://www.ncenet.com/wp-content/uploads/2020/04/No-image-found.jpg";
  Item item;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   _getThingsOnStartup(context);
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getThingsOnStartup(context);
    });
  }

  void showInSnackBar(String msg) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'DONE',
          onPressed: () {},
        )));
  }

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      if (item != null) {
        item.img = _imageController.text.trim();
        item.name = _nameController.text.trim();
        item.price = double.parse(_priceController.text.trim());
        item.description = _descriptionController.text.trim();
        item.available = _statusController.text.trim().toLowerCase() == "true";
        MyApi().updateItem(item.id, item).then((value) => {
              if (value)
                {MyUtil.showSnackBar(context, 'Item updated')}
              else
                {MyUtil.showSnackBar(context, 'Update item failed')}
            });
      } else {
        Item newItem = new Item(
            id: null,
            available: _statusController.text.trim().toLowerCase() == "true",
            description: _descriptionController.text.trim(),
            img: _imageController.text.trim(),
            name: _nameController.text.trim(),
            price: double.parse(_priceController.text.trim()));
        MyApi().createItem(newItem).then((value) => {
              if (value)
                {
                  Navigator.pop(context),
                  MyUtil.showSnackBar(context, 'Item created')
                }
              else
                {MyUtil.showSnackBar(context, 'Create item failed')}
            });
      }
    } else {
      MyUtil.showSnackBar(context, 'Form is invalid');
    }
  }

  Future _getThingsOnStartup(context) async {
    item = ModalRoute.of(context).settings.arguments;
    if (item != null) {
      if (item.name != null && item.name.trim().isNotEmpty) {
        _nameController.text = item.name;
      }
      if (item.price != null && item.price.toString().trim().isNotEmpty) {
        _priceController.text = item.price.toString();
      }
      if (item.description != null && item.description.trim().isNotEmpty) {
        _descriptionController.text = item.description;
      }
      if (item.available != null) {
        _statusController.text = item.available.toString();
      }
      if (item.img != null && item.img.trim().isNotEmpty) {
        _imageController.text = item.img;
        setState(() {
          img = item.img;
        });
      }
    }
  }

  body() {
    return ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // ItemImage(
          //     imgSrc:
          //         _imageController.text.isEmpty ? img : _imageController.text),
          DetailForm(
            nameController: _nameController,
            priceController: _priceController,
            desController: _descriptionController,
            statusController: _statusController,
            imageController: _imageController,
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



// class ItemDetailStaffScreen extends StatelessWidget {
//   static String routeName = "/item-detail-staff";
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   var _nameController = TextEditingController();
//   var _priceController = TextEditingController();
//   var _descriptionController = TextEditingController();
//   var _statusController = TextEditingController();
//   var _imgController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   var img =
//       "https://www.ncenet.com/wp-content/uploads/2020/04/No-image-found.jpg";
//   Item item;

//   void _handleSubmitted(context) async {
//     final FormState form = _formKey.currentState;
//     if (form.validate()) {
//       if (item != null) {
//         item.name = _nameController.text.trim();
//         item.price = double.parse(_priceController.text.trim());
//         item.description = _descriptionController.text.trim();
//         item.available = _statusController.text.trim().toLowerCase() == "true";
//         MyApi().updateItem(item.id, item).then((value) => {
//               if (value) {MyUtil.showSnackBar(context, 'Item updated')}
//             });
//       } else {
//         MyUtil.showSnackBar(context, 'Item created');
//       }
//     } else {
//       MyUtil.showSnackBar(context, 'Form is invalid');
//     }
//   }

//   Future _getThingsOnStartup(context) async {
//     item = ModalRoute.of(context).settings.arguments;
//     if (item != null) {
//       if (item.img != null && item.img.trim().isNotEmpty) {
//         img = item.img;
//       }
//       if (item.name != null && item.name.trim().isNotEmpty) {
//         _nameController.text = item.name;
//       }
//       if (item.price != null && item.price.toString().trim().isNotEmpty) {
//         _priceController.text = item.price.toString();
//       }
//       if (item.description != null && item.description.trim().isNotEmpty) {
//         _descriptionController.text = item.description;
//       }
//       if (item.available != null) {
//         _statusController.text = item.available.toString();
//       }
//     }
//   }

//   body(context) {
//     return StatefulWrapper(
//       onInit: () {
//         _getThingsOnStartup(context);
//       },
//       child: ListView(shrinkWrap: true, children: [
//         ItemImage(imgSrc: img),
//         DetailForm(
//           nameController: _nameController,
//           priceController: _priceController,
//           desController: _descriptionController,
//           statusController: _statusController,
//           formKey: _formKey,
//         ),
//       ]),
//     );
//     // return ListView(shrinkWrap: true, children: [
//     //   ItemImage(imgSrc: img),
//     //   DetailForm(
//     //     nameController: _nameController,
//     //     priceController: _priceController,
//     //     desController: _descriptionController,
//     //     statusController: _statusController,
//     //     formKey: _formKey,
//     //   ),
//     // ]);
//   }

//   bottom(context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         vertical: getProportionateScreenWidth(15.0),
//         horizontal: getProportionateScreenWidth(30.0),
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, -15),
//             blurRadius: 20,
//             color: Color(0xFFDADADA).withOpacity(0.15),
//           )
//         ],
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: SizedBox(
//                 width: getProportionateScreenWidth(190.0),
//                 child: DefaultButton(
//                   color: ThemeColors.primary,
//                   text: "Save",
//                   press: () {
//                     _handleSubmitted(context);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildAppBar() {
//     return Navbar(
//       title: "Detail",
//       backButton: true,
//       rightOptionCart: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);

//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: buildAppBar(),
//       body: body(context),
//       bottomNavigationBar: bottom(context),
//     );
//   }
// }
