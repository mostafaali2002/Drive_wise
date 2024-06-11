import 'package:our_project_1/home/home.dart';
import 'package:our_project_1/modules/Choose/choose.dart';
import 'package:our_project_1/modules/Home_layout/home_loyout.dart';
import 'package:our_project_1/modules/Like%20Splash/splash.dart';
import 'package:our_project_1/modules/Verify/test.dart';
import 'package:our_project_1/modules/Verify/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:our_project_1/modules/administrator/admininstrator.dart';
import 'package:our_project_1/modules/administrator/datatable.dart';
import 'package:our_project_1/modules/administrator/login_admin.dart';
import 'package:our_project_1/modules/change/change_name/change_name.dart';
import 'package:our_project_1/modules/change/change_password/change_password.dart';
import 'package:our_project_1/modules/login/login.dart';

import 'package:our_project_1/modules/sign_up/sign_up.dart';
import 'package:our_project_1/provider/provider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:our_project_1/modules/Forget_pass/forget_password.dart';

// Set the language codeawait FirebaseAuth.instance.setLanguageCode('en');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => UserState()..loadUsername(),
    child: OurApplication(),
  ));
}

class OurApplication extends StatelessWidget {
  const OurApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const VerifyEmailScreen();
            } else {
              return const LoginView();
            }
          },
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        LoginView.routeName: (context) => const LoginView(),
        RegisterView.routeName: (context) => const RegisterView(),
        Home_layout.routeName: (context) => const Home_layout(),
        Choose.routeName: (context) => const Choose(),
        Login_Admin.routeName: (context) => const Login_Admin(),
        Adminstrator.routeName: (context) => const Adminstrator(),
        User_Data.routeName: (context) => const User_Data(),
        Home.routeName: (context) => Home(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        ForgotPassword.routeName: (context) => const ForgotPassword(),
        Test.routeName: (context) => const Test(),
        ChangeName.routeName: (context) => const ChangeName(),
        ChangePassword.routeName: (context) => const ChangePassword(),
        VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
      },
    );
  }
}
