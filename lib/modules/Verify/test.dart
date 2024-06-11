import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../change/change_password/change_password.dart';
import '../change/change_name/change_name.dart';

class Test extends StatefulWidget {
  static const String routeName = "Test";

  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool login = false;

  var email = TextEditingController();
  var password = TextEditingController();

  var displayName = TextEditingController();

  var currentPass = TextEditingController();
  var newPass = TextEditingController();
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        if (mounted) {
          setState(() {
            login = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
        width: 350,
        child: ListView(children: [
          login
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 92.0),
                        child: Image(
                            image: AssetImage("images/profile.png"),
                            width: 117),
                      ),
                      const Image(image: AssetImage("images/stars.png"), width: 117),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          FirebaseAuth.instance.currentUser!.displayName ??
                              'No Name',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ChangeName.routeName);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFF8E0C19),
                                ),
                                width: 216,
                                height: 47,
                                child: const Text("Change Name",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                    )),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ChangePassword.routeName);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFF8E0C19),
                                ),
                                width: 216,
                                height: 47,
                                child: const Text("Change Password",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                    )),
                              )),
                        ),
                      ])
                      /* Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xff8E0C19)),
                        fixedSize: MaterialStatePropertyAll(Size(100, 30))),

                      onPressed: () async {
                       Navigator.pushReplacementNamed(context,LoginView.routeName);
                      },
                      child: const Text('LogOut')),
                )*/
                    ],
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
        ]),
      ),
    );
  }
}
