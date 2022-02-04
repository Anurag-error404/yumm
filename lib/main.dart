import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:yumm/auth/auth.dart';
import 'package:yumm/screens/home_screen.dart';
import 'package:yumm/sign-up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          canvasColor: Colors.grey[300],
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xff02040F)),
          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(
                  backgroundColor:
                      Color(0xffE59500)),
          // 002642
          // E59500
          primarySwatch: Colors.amber,
          primaryColor: const Color(0xffE59500),
        ),
        home: const MyHomePage(title: 'Yumm'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() =>
      _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('asset/img/login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Hi, Welcome to Yumm',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight:
                          FontWeight.bold),
                ),
                const SizedBox(
                  height: 150,
                ),
                Container(
                  padding:
                      const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius:
                          BorderRadius.circular(
                              10)),
                  child: Column(
                    children: [
                      Center(
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _email =
                                  value.trim();
                            });
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.red,

                          onSaved: (value) {
                            // userMail = value;
                          },
                          keyboardType:
                              TextInputType
                                  .emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field can not be empty";
                            } else {
                              return null;
                            }
                          },
                          decoration:
                              const InputDecoration(
                            prefixIcon:
                                IconButton(
                              icon: Icon(
                                  Icons.mail),
                              onPressed: (null),
                            ),
                            hintText:
                                'Enter Your Email',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          // controller: emailTextController,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _password =
                                  value.trim();
                            });
                          },
                          obscureText:
                              _obscureText,
                          style: const TextStyle(
                            // color: Colors.black,
                            color: Colors.white,
                          ),
                          cursorColor: Colors.red,
                          key: const ValueKey(
                              'Password'),
                          onSaved: (value) {
                            // userMail = value;
                          },
                          keyboardType:
                              TextInputType
                                  .emailAddress,
                          validator: (value) {
                            if (value!.length <
                                6) {
                              return "Password too short";
                            } else {
                              return null;
                            }
                          },
                          decoration:
                              InputDecoration(
                            prefixIcon:
                                const IconButton(
                              icon: Icon(
                                Icons.lock,
                              ),
                              onPressed: (null),
                            ),
                            suffixIcon:
                                IconButton(
                              icon: const Icon(
                                  Icons
                                      .visibility),
                              onPressed: () {
                                _toggle();
                              },
                            ),
                            hintText: 'Password',
                            hintStyle:
                                const TextStyle(
                              // color: Colors.black,
                              color: Colors.white,
                            ),
                          ),
                          // controller: passwordTextController,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10),
                  child: MaterialButton(
                    onPressed: () {
                      Auth().emailLogin(context,
                          _email, _password);
                    },
                    color: Theme.of(context)
                        .appBarTheme
                        .backgroundColor!
                        .withOpacity(0.8),
                    minWidth: size.width * 0.95,
                    height: 50,
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10),
                  child: MaterialButton(
                    onPressed: () {
                      Auth().loginGoogle(context);
                    },
                    color: Colors.white
                        .withOpacity(0.8),
                    minWidth: size.width * 0.95,
                    height: 50,
                    child: const Text(
                      'Google',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                              FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) =>
                                  SignUp()));
                    },
                    child: Text("Don't have an account? Sign up", style:  TextStyle(color: Colors.white, fontSize: 18),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
