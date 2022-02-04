import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumm/screens/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key})
      : super(key: key);

  @override
  State<WelcomeScreen> createState() =>
      _WelcomeScreenState();
}

class _WelcomeScreenState
    extends State<WelcomeScreen> {
  var userUid = "";
  var userMail = "";
  var id = "-1";
  var _name = "";

  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  void inputData() {
    setState(() {
      final User? user = auth.currentUser;
      userUid = user!.uid.toString();
      userMail = user.email!;
    });
  }

  getID() {
    setState(() {
      id = firestore
          .collection("items")
          .doc(userUid)
          .id;
    });
  }

  @override
  void initState() {
    super.initState();
    inputData();
    getID();
  }

  _trySubmit() {
    DocumentReference documentReference =
        firestore
            .collection("items")
            .doc(userUid);

    documentReference.get().then((value) async {
      await firestore
          .collection("items")
          .doc(userUid)
          .set({'name ': userMail});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Welcome to yumm',
                style:
                    GoogleFonts.gloriaHallelujah(
                  textStyle: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight:
                          FontWeight.w600),
                ),

              ),
              SvgPicture.asset(
                'asset/icon/ham.svg',
                height: 450,
              ),
              
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10),
                child: MaterialButton(
                  onPressed: () {
                    _trySubmit();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) =>
                                const HomeScreen()));
                  },
                  color: Theme.of(context)
                      .primaryColor,
                  minWidth: MediaQuery.of(context)
                          .size
                          .width *
                      0.80,
                  height: 50,
                  child: Text(
                    'Continue',
                    style:
                    GoogleFonts.gloriaHallelujah(
                  textStyle: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight:
                          FontWeight.w600),),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
