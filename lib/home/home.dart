import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:our_project_1/home/speed_distance.dart';
import 'package:our_project_1/shared/components/components.dart';
import 'package:our_project_1/shared/components/constant.dart';
import 'package:provider/provider.dart';
import 'package:our_project_1/modules/login/login.dart';
import 'package:our_project_1/provider/provider.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

final String userID = Random().nextInt(10000).toString();

class Home extends StatefulWidget {
  static const String routeName = "Home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = PageController(initialPage: 0);
  var displayName = TextEditingController();
  var currentPass = TextEditingController();
  var newPass = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  bool ispasswordcurrent = true;
  bool ispasswordNew = true;
  bool isVisable = false;

  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Consumer<UserState>(builder: (context, userState, _) {
      return Scaffold(
          key: scaffoldKey,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
            leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  size: 60,
                ),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                }),
            actions: [
              Column(
                children: [
                  Text(
                    ' ${userState.username}',
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  GetRating(rate: Rating.rate)
                ],
              ),
              CircleAvatar(
                radius: 70.0,
                child: Image.asset('images/profile.png'),
              ),
            ],
          ),
          drawer: Drawer(
              backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
              width: 350,
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: controller,
                children: [
                  // first drawer open
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: CircleAvatar(
                          radius: 70.0,
                          child: Image.asset('images/profile.png'),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.only(left: 100),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 30),
                            Icon(Icons.star, color: Colors.amber, size: 30),
                            Icon(Icons.star, color: Colors.amber, size: 30),
                            Icon(Icons.star, color: Colors.amber, size: 30),
                            Icon(Icons.star_half,
                                color: Colors.amber, size: 30),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          ' ${userState.username}',
                          style: const TextStyle(
                              fontSize: 30, color: Colors.white),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          controller.jumpToPage(1);
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 17.0, bottom: 100),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xFF8E0C19),
                            ),
                            width: 157,
                            height: 47,
                            child: const Text("Setting",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.jumpToPage(2);
                        },
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 13.0),
                              child: Icon(
                                Icons.announcement_outlined,
                                color: Color(0xFF8E0C19),
                                size: 40,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "About DriveWise",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 10,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 13.0),
                            child: Icon(
                              Icons.logout,
                              color: Color(0xFF8E0C19),
                              size: 40,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.transparent)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor:
                                        const Color.fromRGBO(29, 29, 29, 1),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(fontSize: 20),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacementNamed(
                                                context, LoginView.routeName);
                                          },
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(fontSize: 20),
                                          ))
                                    ],
                                    icon: const Icon(Icons.warning,
                                        size: 35, color: Colors.amber),
                                    title: const Text(
                                      'Warning',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                    content: const Text(
                                      'Are You Sure You Want To Log Out',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "LogOut",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  //change password after drawer change password
                  ListView(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 250, top: 20),
                      child: IconButton(
                          onPressed: () {
                            controller.jumpToPage(0);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 40,
                            color: Colors.white,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: CircleAvatar(
                        radius: 70.0,
                        child: Image.asset('images/profile.png'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(left: 100.0),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 30),
                          Icon(Icons.star, color: Colors.amber, size: 30),
                          Icon(Icons.star, color: Colors.amber, size: 30),
                          Icon(Icons.star, color: Colors.amber, size: 30),
                          Icon(Icons.star_half, color: Colors.amber, size: 30),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        ' ${userState.username}',
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 30),
                    MaterialButton(
                      onPressed: () {
                        controller.jumpToPage(3);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFF8E0C19),
                        ),
                        width: 170,
                        height: 55,
                        child: const Center(
                          child: Text("Change Password",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 70, left: 25),
                    // about drawer
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 250, bottom: 50),
                          child: IconButton(
                              onPressed: () {
                                controller.jumpToPage(0);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 40,
                                color: Colors.white,
                              )),
                        ),
                        const Text(
                          textAlign: TextAlign.center,
                          'About',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        const Text(
                          '1-Teaching the driver proper driving',
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          '2-Driver driving evaluation',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          maxLines: 2,
                          '3-Holding the driver accountable for his mistakes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //change password exactly
                  ListView(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 250, top: 20),
                            child: IconButton(
                                onPressed: () {
                                  controller.jumpToPage(1);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 40,
                                  color: Colors.white,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: CircleAvatar(
                              radius: 70.0,
                              child: Image.asset('images/profile.png'),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Padding(
                            padding: EdgeInsets.only(left: 100),
                            child: Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 30),
                                Icon(Icons.star, color: Colors.amber, size: 30),
                                Icon(Icons.star, color: Colors.amber, size: 30),
                                Icon(Icons.star, color: Colors.amber, size: 30),
                                Icon(Icons.star_half,
                                    color: Colors.amber, size: 30),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              ' ${userState.username}',
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
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
                              style: const TextStyle(fontSize: 20),
                              controller: currentPass,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
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
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
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
                                style: const TextStyle(fontSize: 20),
                                controller: newPass,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
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
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 15, right: 15),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff8E0C19)),
                                    fixedSize: const MaterialStatePropertyAll(
                                        Size(200, 45))),
                                onPressed: () async {
                                  if (displayName.value.text.isNotEmpty) {
                                    try {
                                      await FirebaseAuth.instance.currentUser!
                                          .updateDisplayName(displayName.text);
                                      if (!mounted) return;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()));
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print(e);
                                      }
                                    }
                                  }
                                  if (currentPass.value.text.isNotEmpty &&
                                      newPass.value.text.isNotEmpty) {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: FirebaseAuth
                                                .instance.currentUser!.email!,
                                            password: currentPass.text);
                                    await FirebaseAuth.instance.currentUser!
                                        .updatePassword(newPass.text);
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Update Success')));
                                    Navigator.pushReplacementNamed(
                                        context, LoginView.routeName);
                                  }
                                },
                                child: const Text(
                                  'Change',
                                  style: TextStyle(fontSize: 25),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 150),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          color: Colors.white,
                          height: 550,
                          width: 1000,
                          child: LivePage(liveID: '1084918026'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                            background: const Color(0xFF8E0C19),
                            text: "Car's information",
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Speed_distance()));
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 100.0,
                  ),
                ]),
          ));
    });
  }

  jumpToLivePage(BuildContext context, {required bool isHost}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LivePage(
                  isHost: isHost,
                  liveID: '1084918026',
                )));
  }
}

class LivePage extends StatelessWidget {
  final String liveID;
  final bool isHost;

  LivePage({super.key, required this.liveID, this.isHost = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ZegoUIKitPrebuiltLiveStreaming(
            appID:
                1084918026, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
            appSign:
                'cef4d7a88b67ce3daa8f2cfeb7b6df1fc869640b9226652cb0ec9a14f7a9d81b', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
            userID: userID,
            userName: 'user_$userID',
            liveID: liveID,
            config: isHost
                ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
                : (ZegoUIKitPrebuiltLiveStreamingConfig.audience())));
  }
}
