import 'package:flutter/material.dart';
import 'package:kiennt_restaurant/configs/size_config.dart';
import 'package:kiennt_restaurant/constants/Theme.dart';
import 'package:kiennt_restaurant/models/item.dart';
import 'package:kiennt_restaurant/screens/menu_staff_side/details/detail_form.dart';
import 'package:kiennt_restaurant/screens/setting/setting_form.dart';
import 'package:kiennt_restaurant/services/api.dart';
import 'package:kiennt_restaurant/services/storage/local_storage.dart';
import 'package:kiennt_restaurant/util/my_util.dart';
import 'package:kiennt_restaurant/widgets/default_button.dart';
import 'package:kiennt_restaurant/widgets/navbar.dart';
import 'package:kiennt_restaurant/widgets/stateful_warpper.dart';

class ItemDetailStaffScreen extends StatefulWidget {
  static String routeName = "/item-detail-staff";

  @override
  _ItemDetailStaffScreenState createState() => _ItemDetailStaffScreenState();
}

class _ItemDetailStaffScreenState extends State<ItemDetailStaffScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _nameController = TextEditingController();
  var _priceController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _statusController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var img = null;
  Item item;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getThingsOnStartup(context);
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
      item.name = _nameController.text;
      item.price = double.parse(_priceController.text);
      item.description = _descriptionController.text;
      item.available = _statusController.text.toLowerCase() == "true";
      MyApi()
        .updateItem(
            item.id, item)
        .then((value) => {
              if (value)
                {
                  MyUtil.showSnackBar(context, 'Item updated')
                }
            });
    } else {
      MyUtil.showSnackBar(context, 'Form is invalid');
    }
  }

  Future _getThingsOnStartup(context) async {
    item = ModalRoute.of(context).settings.arguments;
    if (item != null && item.name != null && item.name.trim().isNotEmpty) {
      _nameController.text = item.name;
    }
    if (item != null &&
        item.price != null &&
        item.price.toString().trim().isNotEmpty) {
      _priceController.text = item.price.toString();
    }
    if (item != null &&
        item.description != null &&
        item.description.trim().isNotEmpty) {
      _descriptionController.text = item.description;
    }
    if (item != null && item.available != null) {
      _statusController.text = item.available.toString();
    }
    if (item != null && item.img != null && item.img.trim().isNotEmpty) {
      img = item.img;
    }
  }

  body(context) {
    return ListView(shrinkWrap: true, children: [
      ItemImage(imgSrc: img),
      DetailForm(
        nameController: _nameController,
        priceController: _priceController,
        desController: _descriptionController,
        statusController: _statusController,
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
                  text: "Update",
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
      body: body(context),
      bottomNavigationBar: bottom(),
    );
  }
}

class ItemImage extends StatelessWidget {
  final String imgSrc;
  const ItemImage({
    Key key,
    this.imgSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.network(
      imgSrc ??
          "https://www.ncenet.com/wp-content/uploads/2020/04/No-image-found.jpg",
      height: size.height * 0.4,
      width: double.infinity,
      // it cover the 25% of total height
      fit: BoxFit.fill,
    );
  }
}
