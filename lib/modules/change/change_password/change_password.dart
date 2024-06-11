import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../login/login.dart';
import '../../Verify/test.dart';

class ChangePassword extends StatefulWidget {
  static const String routeName = "ChangePassword";

  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var email = TextEditingController();
  var password = TextEditingController();
  var currentPass = TextEditingController();
  var newPass = TextEditingController();
  var displayName = TextEditingController();
  bool isVisable = false;
  bool isObscure = false;
  // get isObscure => null;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/img_2.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 92.0),
              child: Image(image: AssetImage("images/profile.png"), width: 117),
            ),
            const Image(image: AssetImage("images/stars.png"), width: 117),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                FirebaseAuth.instance.currentUser!.displayName ?? 'No Name',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                obscureText: true,
                controller: currentPass,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.grey,
                  label: const Text("Current Password",
                      style: TextStyle(color: Colors.black)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Current Password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      isVisable = !isVisable;
                      setState(() {});
                    },
                    child: isVisable == true
                        ? const Icon(Icons.visibility_off_outlined,
                            color: Colors.black)
                        : const Icon(
                            Icons.visibility_outlined,
                            color: Colors.black,
                          ),
                  ),
                ),
                /* obscureText: isObscure== true
                    ?isVisable
                    :!isVisable,*/
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                  obscureText: true,
                  controller: newPass,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Colors.grey,
                    label: const Text("New Password",
                        style: TextStyle(color: Colors.black)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'New Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        isVisable = !isVisable;
                        setState(() {});
                      },
                      child: isVisable == true
                          ? const Icon(Icons.visibility_off_outlined,
                              color: Colors.black)
                          : const Icon(
                              Icons.visibility_outlined,
                              color: Colors.black,
                            ),
                    ),
                  )
                  /*   obscureText: isObscure== true
                    ?isVisable
                    :!isVisable,*/
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff8E0C19)),
                      fixedSize: const MaterialStatePropertyAll(Size(100, 30))),
                  onPressed: () async {
                    if (displayName.value.text.isNotEmpty) {
                      try {
                        await FirebaseAuth.instance.currentUser!
                            .updateDisplayName(displayName.text);
                        if (!mounted) return;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Test()));
                      } catch (e) {
                        if (kDebugMode) {
                          print(e);
                        }
                      }
                    }
                    if (currentPass.value.text.isNotEmpty &&
                        newPass.value.text.isNotEmpty) {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: FirebaseAuth.instance.currentUser!.email!,
                          password: currentPass.text);
                      await FirebaseAuth.instance.currentUser!
                          .updatePassword(newPass.text);
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Update Success')));
                      Navigator.pushReplacementNamed(
                          context, LoginView.routeName);
                    }
                  },
                  child: const Text('Change')),
            ),
          ],
        ),
      ),
    );
  }
}
