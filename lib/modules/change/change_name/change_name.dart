import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:our_project_1/modules/Verify/test.dart';
import 'package:our_project_1/modules/login/login.dart';

class ChangeName extends StatefulWidget {
  @override
  static const String routeName = "ChangeName";

  const ChangeName({super.key});
  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  @override
  var displayName = TextEditingController();

  var currentPass = TextEditingController();
  var newPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/img_2.png"), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 92.0),
                child: Image(
                    image: AssetImage("assets/images/profile.png"), width: 117),
              ),
              const Image(image: AssetImage("assets/images/stars.png"), width: 117),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  FirebaseAuth.instance.currentUser!.displayName ?? 'No Name',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: displayName,
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
                    label: const Text("Change Name",
                        style: TextStyle(color: Colors.black)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    //prefixIcon: Icon(Icons.perm_identity,color: Colors.black,),

                    hintText: FirebaseAuth.instance.currentUser!.displayName ??
                        'Change Name',
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
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
          )),
    );
  }
}
