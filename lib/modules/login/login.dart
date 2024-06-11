import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:our_project_1/home/home.dart';
import 'package:our_project_1/modules/Forget_pass/forget_password.dart';
import 'package:our_project_1/modules/sign_up/sign_up.dart';
import 'package:our_project_1/shared/components/components.dart';

class LoginView extends StatefulWidget {
  static const String routeName = "Login";

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isVisable = false;

  get isObscure => null;
  bool ispassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: Image.asset(
            "images/cardd.jpg",
            fit: BoxFit.fitWidth,
          ),
          toolbarHeight: 350,
        ),
        body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: defaultTextFormField(
                          hintText: "example@gmail.com",
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                          validate: (value) {
                            var regex = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                            if (!regex.hasMatch(value)) {
                              return "Invalid email address";
                            }
                            if (value == null || value.trim().isEmpty) {
                              return "you must enter your email address";
                            }

                            return null;
                          },
                          prefix: Icons.email,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 30),
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
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: ispassword,
                          decoration: InputDecoration(
                            filled: true,
                            errorStyle: const TextStyle(fontSize: 20),
                            hintText: 'Password',
                            fillColor: Colors.white70,
                            labelStyle: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w400),
                            hintStyle: const TextStyle(
                                color: Color.fromRGBO(134, 118, 118, 1)),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                              size: 40,
                            ),
                            suffixIcon: togglePassword(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onFieldSubmitted: (String value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 950),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ForgotPassword.routeName);
                              },
                              child: const Text(
                                "Forget password ?",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Column(children: [
                          Container(
                            decoration: BoxDecoration(
                              //color: Color.fromRGBO(79, 172, 254, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: MaterialButton(
                                onPressed: () {
                                  login();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xFF8E0C19),
                                  ),
                                  width: 350,
                                  height: 60,
                                  child: const Text("Login",
                                      style: TextStyle(
                                        fontSize: 35.0,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                            child: Text(
                              "Don’t have account?",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(255, 255, 255, 0.75),
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RegisterView.routeName);
                              },
                              child: const Text(
                                "Sing up",
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 0.75),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                        ]),
                      )
                    ]),
              ),
            ),
          ),
        ));
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          ispassword = !ispassword;
        });
      },
      icon: ispassword
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: Colors.black,
      iconSize: 40,
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
        print("Homepage");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        }
      }
    }
  }
}
