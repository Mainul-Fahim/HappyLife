import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterdoctor/config/config.dart';
import 'package:flutterdoctor/home_screen.dart';
import 'package:flutterdoctor/login_screen.dart';
import 'package:flutterdoctor/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme:
          ThemeData(primaryColor: primaryColor, brightness: Brightness.light),
      darkTheme:
          ThemeData(brightness: Brightness.dark, primaryColor: primaryColor),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _auth.onAuthStateChanged,
        builder: (ctx, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            FirebaseUser user = snapshot.data;

            if (user != null) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          }

          return OnboardingScreen();
        },
      ),
    );
  }
}
