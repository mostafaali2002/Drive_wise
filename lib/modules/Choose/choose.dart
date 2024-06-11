import 'package:flutter/material.dart';
import 'package:our_project_1/modules/administrator/login_admin.dart';
import 'package:our_project_1/modules/login/login.dart';
import 'package:our_project_1/shared/components/components.dart';

class Choose extends StatefulWidget {
  const Choose({super.key});
  static const String routeName = "choose";

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Image(
              image: AssetImage('images/car2.jpg'),
              height: 550,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const Spacer(
              flex: 1,
            ),
            defaultButton(
                background: const Color.fromRGBO(142, 12, 25, 1),
                text: 'User',
                function: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoginView()));
                }),
            const SizedBox(
              height: 25,
            ),
            defaultButton(
                textcolor: Colors.black,
                background: Colors.white,
                text: 'Admin',
                function: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login_Admin()));
                }),
            const Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
