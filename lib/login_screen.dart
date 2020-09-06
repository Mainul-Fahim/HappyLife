import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdoctor/config/config.dart';
import 'package:flutterdoctor/email_pass_signup.dart';
import 'package:flutterdoctor/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Firestore _db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 40,
                ),
                child: Image(
                  image: AssetImage("assets/login.jpeg"),
                  width: 120,
                  height: 120,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    hintText: "Write Email Here",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(
                  top: 5,
                ),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Write Password Here",
                  ),
                  obscureText: true,
                ),
              ),
              InkWell(
                onTap: () {
                  _signIn();
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        secondaryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  child: Center(
                      child: Text(
                    "Login With Email",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailPassSignupScreen()));
                },
                child: Text("Signup using Email"),
              ),
              Wrap(
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    label: Text(
                      "Sign-In using Gmail",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),
                    label: Text(
                      "Sign-In using Phone",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        if (user != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        _db.collection("users").document(user.user.uid).setData({
          "email": email,
          "lastseen": DateTime.now(),
        });

        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text("Done"),
                content: Text("Sign in succesfully"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("cancel"),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              );
            });
      }).catchError((e) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text("Error"),
                content: Text("${e.message}"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("cancel"),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              );
            });
      });
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text("Error"),
              content: Text("Please provide email and password.."),
              actions: <Widget>[
                FlatButton(
                  child: Text("cancel"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    _emailController.text = "";
                    _passwordController.text = "";
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            );
          });
    }
  }
}
