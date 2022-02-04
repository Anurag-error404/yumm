import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuList extends StatefulWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  _MenuListState createState() =>
      _MenuListState();
}

class _MenuListState extends State<MenuList> {
  var userUid = "";
  void inputData() {
    setState(() {
      final FirebaseAuth auth =
          FirebaseAuth.instance;

      final User? user = auth.currentUser;
      userUid = user!.uid.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    inputData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Menu'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('items')
              .doc(userUid)
              .collection('menu-list')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(
                child:
                    CircularProgressIndicator(),
              );
            }
            var menuData = snapshot.data!.docs;

            // return Container();
            return ListView.builder(
                itemCount: menuData.length,
                itemBuilder:
                    (BuildContext context,
                        index) {
                  return menuData.length == 0
                      ? Container(
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'asset/icon/ham.svg',
                                height: 400,
                              ),
                              Text(
                                "It's all empty here! Add some items first",
                                style: GoogleFonts
                                    .gloriaHallelujah(
                                        textStyle:
                                            const TextStyle(
                                  fontSize: 30,
                                  color: Colors
                                      .black,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                )),
                              )
                            ],
                          ),
                        )
                      : Container(
                          padding:
                              EdgeInsets.all(10),
                          width: MediaQuery.of(
                                      context)
                                  .size
                                  .width *
                              0.95,
                          decoration:
                              BoxDecoration(
                                  // color: Colors.grey[600],
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              10)),
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .center,
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    menuData[
                                            index]
                                        [
                                        'itemName'],
                                    style: TextStyle(
                                        color: Colors
                                            .black,
                                        fontSize:
                                            20,
                                        fontWeight:
                                            FontWeight
                                                .w600),
                                  ),
                                  Text(
                                    menuData[
                                            index]
                                        [
                                        'timeStamp'],
                                    style: TextStyle(
                                        color: Colors
                                                .grey[
                                            600]),
                                  )
                                ],
                              ),
                              Text(
                                menuData[index]
                                    ['quantity'],
                                style: TextStyle(
                                    color: Colors
                                            .amber[
                                        800],
                                    fontSize: 30,
                                    fontWeight:
                                        FontWeight
                                            .bold),
                              ),
                            ],
                          ));
                });
          }),
    );
  }
}
