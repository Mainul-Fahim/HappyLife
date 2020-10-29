import 'package:flutter/material.dart';
import 'package:flutterdoctor/login_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'email_pass_signup.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pages = [
    PageViewModel(
      title: "Individual",
      body: "Single person can take individual counseling...",
      image: Center(child: Image.asset("assets/individual.png", height: 175.0)),
      decoration: const PageDecoration(
        pageColor: Colors.cyan,
        bodyTextStyle: TextStyle(color: Colors.white, fontSize: 15),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    PageViewModel(
      title: "Couple",
      body: "Couple can take counseling together...",
      image: Center(child: Image.asset("assets/couple.jpeg", height: 175.0)),
      decoration: const PageDecoration(
        pageColor: Colors.cyan,
        bodyTextStyle: TextStyle(color: Colors.white, fontSize: 16),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    PageViewModel(
      title: "Child",
      body: "Child can take counseling...",
      image: Center(child: Image.asset("assets/child.jpeg", height: 175.0)),
      decoration: const PageDecoration(
        pageColor: Colors.cyan,
        bodyTextStyle: TextStyle(color: Colors.white, fontSize: 16),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: pages,
        onDone: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        onSkip: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        showSkipButton: true,
        skip: const Icon(
          Icons.skip_next,
          color: Colors.white,
        ),
        next: const Icon(
          Icons.arrow_right,
          color: Colors.white,
        ),
        done: const Text("Done",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            )),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.deepOrange,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
