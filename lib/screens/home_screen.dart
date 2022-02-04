import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumm/auth/auth.dart';
import 'package:yumm/main.dart';
import 'package:yumm/models/burgers-data.dart';
import 'package:yumm/screens/menu_list.dart';
import 'package:yumm/widgets/burger-grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() =>
      _HomeScreenState();
}

_logout(context) {
  Auth().logout;
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (ctx) => const MyHomePage(
        title: 'Yumm',
      ),
    ),
  );
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  // var itemName = "";
  // var price = "";
  // var timeStamp = "";
  var timeStamp;
  var burger;
  var qty;
  var price;
  var userUid = "";
  var id = "-1";
  var now = DateTime.now();
  // static const menuItems = <String>[
  //   "Non-Veg Classic",
  //   "Crispy Meat",
  //   "Veg Classic",
  //   "Veg Double Patty",
  //   "Chicken Cheese",
  //   "Mac Cheese",
  // ];

  // static const quantity = <int>[1, 2, 3, 4];

  // final List<DropdownMenuItem<String>>
  //     _dropDownMenuItems = menuItems
  //         .map((String value) =>
  //             DropdownMenuItem<String>(
  //               value: value,
  //               child: Text(value),
  //             ))
  //         .toList();

  // final List<DropdownMenuItem<String>>
  //     _dropDownMenuItemsQuantity = quantity
  //         .map((int value) =>
  //             DropdownMenuItem<String>(
  //               value: value.toString(),
  //               child: Text(value.toString()),
  //             ))
  //         .toList();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  void inputData() {
    setState(() {
      final User? user = auth.currentUser;
      userUid = user!.uid.toString();
    });
  }

  getID() {
    setState(() {
      id = firestore
          .collection("items")
          .doc(userUid)
          .collection("menu-list")
          .doc()
          .id;
    });
  }

  @override
  void initState() {
    super.initState();
    inputData();
  }

  // _calculatePrice() {
  //   if (burger == "Non-Veg Classic") {
  //     price =
  //         (qty == 0 ? 0 : ((qty as int) * 150));
  //   } else if (burger == "Crispy Meat") {
  //     price = (qty == 0 ? 0 : (qty! * 250));
  //   } else if (burger == "Veg Classic") {
  //     price = (qty == 0 ? 0 : (qty! * 120));
  //   } else if (burger == "Veg Double Patty") {
  //     price = (qty == 0 ? 0 : (qty! * 170));
  //   } else if (burger == "Chicken Cheese") {
  //     price = (qty == 0 ? 0 : (qty! * 250));
  //   } else if (burger == "Mac Cheese") {
  //     price = (qty == 0 ? 0 : (qty! * 150));
  //   }
  // }

  _trySubmit() {
    DocumentReference documentReference =
        firestore
            .collection("items")
            .doc(userUid)
            .collection("menu-list")
            .doc(id);

    bool isValid =
        _formKey.currentState!.validate();
    if (isValid) {
      documentReference.get().then((value) async {
        await firestore
            .collection("items")
            .doc(userUid)
            .collection("menu-list")
            .doc(id)
            .set({
          'itemName': burger,
          'timeStamp': timeStamp,
          'quantity': qty,
        });
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'yumm',
              style: GoogleFonts.gloriaHallelujah(
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight:
                          FontWeight.w600)),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    _logout(context);
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          floatingActionButton:
              FloatingActionButton(
            onPressed: () {
              getID();
              setState(() {
                timeStamp =
                    "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')} ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}";
              });
              // print(timeStamp);
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor:
                      Color(0xff02040F),
                  context: context,
                  builder:
                      (BuildContext context) {
                    return Form(
                      key: _formKey,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(
                                horizontal: 10),
                        height: size.height * 0.7,
                        child:
                            SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context);
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors
                                      .white,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child:
                                    TextFormField(
                                  onChanged:
                                      (value) {
                                    setState(() {
                                      burger = value
                                          .trim();
                                    });
                                  },
                                  style:
                                      const TextStyle(
                                    color: Colors
                                        .white,
                                  ),
                                  cursorColor:
                                      Colors.red,
                                  keyboardType:
                                      TextInputType
                                          .name,
                                  validator:
                                      (value) {
                                    if (value!
                                        .isEmpty) {
                                      return "This field can not be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration:
                                      InputDecoration(
                                    prefixIcon:
                                        IconButton(
                                      icon: Icon(
                                        Icons
                                            .food_bank,
                                        color: Theme.of(
                                                context)
                                            .primaryColor,
                                      ),
                                      onPressed:
                                          (null),
                                    ),
                                    hintText:
                                        'Burger Name',
                                    hintStyle:
                                        TextStyle(
                                      color: Colors
                                          .white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child:
                                    TextFormField(
                                  onChanged:
                                      (value) {
                                    setState(() {
                                      qty = value;
                                    });
                                  },
                                  style:
                                      const TextStyle(
                                    color: Colors
                                        .white,
                                  ),
                                  cursorColor:
                                      Colors.red,
                                  keyboardType:
                                      TextInputType
                                          .name,
                                  validator:
                                      (value) {
                                    if (value!
                                        .isEmpty) {
                                      return "This field can not be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration:
                                      InputDecoration(
                                    prefixIcon:
                                        IconButton(
                                      icon: Icon(
                                        Icons
                                            .control_point_outlined,
                                        color: Theme.of(
                                                context)
                                            .primaryColor,
                                      ),
                                      onPressed:
                                          (null),
                                    ),
                                    hintText:
                                        'Quantity',
                                    hintStyle:
                                        TextStyle(
                                      color: Colors
                                          .white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    size.height *
                                        0.3,
                              ),
                              Center(
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              10),
                                  child:
                                      MaterialButton(
                                    onPressed:
                                        () {
                                      // _calculatePrice();
                                      _trySubmit();
                                    },
                                    color: Theme.of(
                                            context)
                                        .primaryColor,
                                    minWidth: MediaQuery.of(
                                                context)
                                            .size
                                            .width *
                                        0.95,
                                    height: 50,
                                    child:
                                        const Text(
                                      'Submit',
                                      style: TextStyle(
                                          fontSize:
                                              20,
                                          color: Colors
                                              .black,
                                          fontWeight:
                                              FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: const Icon(Icons.menu_book),
          ),
          body: Column(
            children: [
              Container(
                height: size.height * 0.8,
                child: const BurgerGrid(),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              const MenuList()));
                },
                child: const Text(
                  "Menu List",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffE5DADA),
                  ),
                ),
                minWidth: size.width * 0.96,
                height: 50,
                color: const Color(0xff02040f),
              )
            ],
          )),
    );
  }
}
