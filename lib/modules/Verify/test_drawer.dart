import 'package:flutter/material.dart';

class Test_Drawer extends StatefulWidget {
  const Test_Drawer({super.key});

  @override
  State<Test_Drawer> createState() => _Test_DrawerState();
}

class _Test_DrawerState extends State<Test_Drawer> {
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const Padding(
        padding: EdgeInsets.only(top: 50),
        child: CircleAvatar(
          backgroundImage: AssetImage('images/profile.png'),
          radius: 70.0,
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: Image(image: AssetImage("images/stars.png"), width: 117),
      ),
      const Center(
        child: Text(
          'Eleven',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      const SizedBox(height: 40),
      MaterialButton(
        onPressed: () {
          controller.nextPage(
              duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFF8E0C19),
          ),
          width: 157,
          height: 47,
          child: const Text("Change Name",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              )),
        ),
      ),
      const SizedBox(height: 30),
      MaterialButton(
        onPressed: () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFF8E0C19),
          ),
          width: 160,
          height: 47,
          child: const Center(
            child: Text("Change Password",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                )),
          ),
        ),
      ),
    ]);
  }
}
