import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yumm/screens/home_screen.dart';
import 'package:yumm/screens/welcome.dart';

class Auth {
  final firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Future<void> emailLogin(ctx, email, password) async {
    try {
      final User? user =
          (await auth.signInWithEmailAndPassword(
                  email: email,
                  password: password))
              .user;

      if (user!.uid.isNotEmpty) {
        Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(
              builder: (context) =>
                  const HomeScreen()),
        );
        showSimpleNotification(
            Text(
                "Succesfully Loggedin in as ${user.email}"),
            position: NotificationPosition.bottom,
            background: Colors.amber[600]);
      } else {
        print('sign in failed!');
        showSimpleNotification(
            const Text(
                "Failed to login. Please try again later"),
            position: NotificationPosition.bottom,
            background: Colors.amber[600]);
        ;
      }
    } catch (e) {
      var errorCode = e.toString();
      if (errorCode ==
          '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
        print('this email isnt registered !');
        showSimpleNotification(
            const Text(
                "Email isn't registered. Please sign up First"),
            position: NotificationPosition.bottom,
            background: Colors.amber[600]);
      } else if (errorCode ==
          '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
        print('invalid password');
        showSimpleNotification(
            const Text(
                "Password Entered is incorrect"),
            position: NotificationPosition.bottom,
            background: Colors.amber[600]);
      } else {
        showSimpleNotification(
            const Text(
                "Some Unexpected Error occured please try again later.")
            ,
                position: NotificationPosition.bottom,
                background: Colors.amber[600]);
      }
      print(e.toString());
    }
  }

  Future<void> signUpWithMail(context, email, password) async {
    // final formState = _formKey.currentState;

    try {
      final User? user = (await auth
              .createUserWithEmailAndPassword(
                  email: email,
                  password: password))
          .user;

      if (user!.uid.isNotEmpty) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) =>
                  const WelcomeScreen()),
        );
      } else {
        print('sign in failed!');
        showSimpleNotification(
            const Text(
                "Failed to SignUp. Please try again later"),
            position: NotificationPosition.bottom,
            background: Colors.red);
      }
    } catch (e) {
      var errorCode = e.toString();
      if (errorCode ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        print(
            'this email is already registered ! Login to continue');
        showSimpleNotification(
            const Text(
                "Email is already registered ! Login to continue"),
            position: NotificationPosition.bottom,
            background: Colors.red);
      } else {
        showSimpleNotification(
            const Text(
                "Some Unexpected Error occured please try again later."),
            position: NotificationPosition.bottom,
            background: Colors.red);
      }
      print(e.toString());
    }
  }

  Future<void> loginGoogle(ctx) async {
    User user;
    final GoogleSignInAccount?
        googleSignInAccount =
        await googleSignIn.signIn();
    try {
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication
            googleSignInAuthentication =
            await googleSignInAccount
                .authentication;

        final AuthCredential credential =
            GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication
              .accessToken,
          idToken:
              googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(
                  credential);

          user = userCredential.user!;

          // ignore: avoid_print
          print(
              "name =============== ${user.displayName}");
          // ignore: avoid_print
          print(
              "uid =============== ${user.uid.toString()}");

          if (userCredential
              .additionalUserInfo!.isNewUser) {
            Navigator.pushReplacement(
                ctx,
                MaterialPageRoute(
                    builder: (ctx) =>
                        const WelcomeScreen()));
          } else {
            Navigator.pushReplacement(
                ctx,
                MaterialPageRoute(
                    builder: (ctx) =>
                        const HomeScreen()));
            showSimpleNotification(Text(
                'succefully signed in as ${user.email}',
                ),
                position: NotificationPosition.bottom,
                background: Colors.amber[600]);
          }
        } on FirebaseAuthException catch (e) {
          // ignore: avoid_print
          print(e);
        }
      } else {
        showSimpleNotification(const Text(
            'Failed to Sign-in. No user found'),
            
                position: NotificationPosition.bottom,
                background: Colors.amber[600]);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> logout() async {
    final GoogleSignIn googleSignIn =
        GoogleSignIn();

    try {
      GoogleSignIn().disconnect();
      googleSignIn.signOut();
      auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
