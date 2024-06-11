import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:our_project_1/modules/administrator/datatable.dart';
import 'package:our_project_1/modules/administrator/information.dart';
import 'package:our_project_1/shared/components/components.dart';

class Adminstrator extends StatefulWidget {
  static const String routeName = "adminstrator";

  const Adminstrator({super.key});

  @override
  State<Adminstrator> createState() => _AdminstratorState();
}

class _AdminstratorState extends State<Adminstrator> {
  var fokey = GlobalKey<FormState>();
  String searchResult = '';
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
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
          height: 450,
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
                      const Center(
                        child: Text(
                          "Enter user's Phone",
                          style: TextStyle(fontSize: 35, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: defaultTextFormField(
                          hintText: "01235468923",
                          controller: phone_User,
                          inputType: TextInputType.phone,
                          validate: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "you must enter phone number";
                            }
                            var regex = RegExp(r'^(?:[+0]9)?0[0-9]{10}$');
                            if (!regex.hasMatch(value)) {
                              return "Invalid phone number";
                            }
                            return null;
                          },
                          prefix: Icons.phone,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 10,
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
                                  String searchQuery = phone_User.text;
                                  searchInFirestore(searchQuery);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xFF8E0C19),
                                  ),
                                  width: 350,
                                  height: 60,
                                  child: const Text("Search",
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
                        ]),
                      )
                    ]),
              ),
            ),
          ),
        ));
  }

  void searchInFirestore(String searchQuery) async {
    if (fokey.currentState!.validate()) {
      try {
        // Query Firestore to find documents matching the search query
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('User')
            .where('Phone', isEqualTo: searchQuery)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Information()));
        } else {
          setState(() {
            // Indicate that no matching data was found
            searchResult = 'No matching data found in Firestore.';
          });
        }
      } catch (error) {
        print('Error searching in Firestore: $error');
        setState(() {
          searchResult = 'Error occurred while searching in Firestore.';
        });
      }
    }
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
