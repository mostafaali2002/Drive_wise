import 'package:our_project_1/modules/Verify/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:our_project_1/provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static const String routeName = "sign_up";
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var formKey = GlobalKey<FormState>();

  bool isVisible = false;
  bool isObscure = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  // final userRepo = Get.put(UserRepo());

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(builder: (context, userState, _) {
      return MaterialApp(
          home: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                flexibleSpace: Image.asset(
                  "images/cardd.jpg",
                  fit: BoxFit.fitWidth,
                ),
                toolbarHeight: 290,
              ),
              body: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Column(children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: nameController,
                                onChanged: (value) {
                                  userState.setUsername(value);
                                },
                                style: const TextStyle(fontSize: 30),
                                decoration: InputDecoration(
                                    errorStyle: const TextStyle(fontSize: 20),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    filled: true,
                                    fillColor: const Color.fromRGBO(
                                        255, 255, 255, 0.75),
                                    hintText: "Name",
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF867676), fontSize: 25),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.perm_identity,
                                      color: Colors.black,
                                      size: 40,
                                    )),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "you must enter your full name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: emailController,
                                style: const TextStyle(fontSize: 30),
                                decoration: InputDecoration(
                                    errorStyle: const TextStyle(fontSize: 20),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    fillColor: const Color.fromRGBO(
                                        255, 255, 255, 0.75),
                                    filled: true,
                                    hintText: "email@gmail.com",
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF867676), fontSize: 25),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.mail_outline,
                                      color: Colors.black,
                                      size: 40,
                                    )),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "you must enter your email address";
                                  }
                                  var regex = RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                  if (!regex.hasMatch(value)) {
                                    return "Invalid email address";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(fontSize: 30),
                                controller: phoneController,
                                decoration: InputDecoration(
                                    errorStyle: const TextStyle(fontSize: 20),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    fillColor: const Color.fromRGBO(
                                        255, 255, 255, 0.75),
                                    filled: true,
                                    hintText: "phone number",
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF867676), fontSize: 25),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.phone,
                                      color: Colors.black,
                                      size: 40,
                                    )),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "you must enter phone number";
                                  }

                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: passwordController,
                                style: const TextStyle(fontSize: 30),
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(fontSize: 20),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(15)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 0.75),
                                  filled: true,
                                  hintText: "password",
                                  hintStyle: const TextStyle(
                                      color: Color(0xFF867676), fontSize: 25),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      isVisible = !isVisible;
                                      setState(() {});
                                    },
                                    child: isVisible == true
                                        ? const Icon(
                                            Icons.visibility_off_outlined,
                                            color: Colors.black,
                                            size: 40,
                                          )
                                        : const Icon(
                                            Icons.visibility_outlined,
                                            color: Colors.black,
                                            size: 40,
                                          ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "you must enter your password";
                                  }
                                  var regex = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                  if (!regex.hasMatch(value)) {
                                    return "Invalid Password";
                                  }
                                  return null;
                                },
                                obscureText:
                                    isObscure == true ? isVisible : !isVisible,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                style: const TextStyle(fontSize: 30),
                                controller: confirmController,
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(fontSize: 20),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(15)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 0.75),
                                  filled: true,
                                  hintText: "confirm password",
                                  hintStyle: const TextStyle(
                                      color: Color(0xFF867676), fontSize: 25),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      isVisible = !isVisible;
                                      setState(() {});
                                    },
                                    child: isVisible == true
                                        ? const Icon(
                                            Icons.visibility_off_outlined,
                                            color: Colors.black,
                                            size: 40,
                                          )
                                        : const Icon(
                                            Icons.visibility_outlined,
                                            color: Colors.black,
                                            size: 40,
                                          ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "you must enter your confirmed password";
                                  }
                                  if (value != passwordController.text) {
                                    return "password doesn't match";
                                  }
                                  return null;
                                },
                                obscureText:
                                    isObscure == true ? isVisible : !isVisible,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  register();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xFF8E0C19),
                                  ),
                                  width: 360,
                                  height: 60,
                                  child: const Text("Sign Up",
                                      style: TextStyle(
                                        fontSize: 35.0,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 84,
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )));
    });
  }

  Future register() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        addData();

        /*
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneController.text,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              print('The provided phone number is not valid.');
            }
          },
          codeSent: (verificationId, forceResendingToken) {},
          codeAutoRetrievalTimeout: (verificationId) {},
        );
        */

        Navigator.pushReplacementNamed(context, VerifyEmailScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> addData() async {
    await FirebaseFirestore.instance.collection('User').add({
      'Phone': phoneController.text,
    });
  }

/*
  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }
  */
}
