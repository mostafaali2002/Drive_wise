import 'package:flutter/material.dart';
import 'package:our_project_1/modules/administrator/admininstrator.dart';
import 'package:our_project_1/shared/components/components.dart';

class Login_Admin extends StatefulWidget {
  const Login_Admin({super.key});
  static const String routeName = "admin";

  @override
  State<Login_Admin> createState() => _Login_AdminState();
}

class _Login_AdminState extends State<Login_Admin> {
  var email = TextEditingController();
  var password = TextEditingController();
  bool ispassword = true;

  var fokey = GlobalKey<FormState>();
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
          height: 800,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: fokey,
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
                          controller: email,
                          inputType: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Email is empty';
                            } else if (value != "Admin2024") {
                              return 'Email is Incorrect';
                            }
                            return null;
                          },
                          prefix: Icons.email,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 30),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is empty';
                            } else if (value != "Admin2024") {
                              return 'password is Incorrect';
                            }
                            return null;
                          },
                          controller: password,
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
                        height: 70,
                      ),
                      Center(
                        child: defaultButton(
                            background: const Color.fromRGBO(142, 12, 25, 1),
                            text: 'Login',
                            function: () {
                              if (fokey.currentState!.validate()) {
                                if (password.value == email.value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Adminstrator()));
                                } else {}
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 20,
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
}
