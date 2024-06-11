import 'dart:async';

import 'package:our_project_1/modules/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:get/get_utils/get_utils.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});
  static const String routeName = "verify_email";

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print("error appear");
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const LoginView()
      : Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            flexibleSpace: Image.asset(
              "images/cardd.jpg",
              fit: BoxFit.cover,
            ),
            toolbarHeight: 350,
          ),
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Verify",
                      style: TextStyle(
                          color: Color(0xFF8E0C19),
                          fontSize: 50,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                const SizedBox(height: 60),
                const Text(
                  "A verification email has been to your email",
                  style: TextStyle(color: Color(0xFFB5ACAC), fontSize: 35),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 100),
                MaterialButton(
                  onPressed: sendVerificationEmail,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromRGBO(255, 255, 255, 0.75),
                    ),
                    width: 350,
                    height: 60,
                    child: const Text("Resend",
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.black,
                        )),
                  ),
                ),
              ],
            ),
          ));
}
