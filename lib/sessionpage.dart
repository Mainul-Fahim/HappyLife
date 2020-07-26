import 'package:flutter/material.dart';
import 'package:flutterdoctor/src/pages/index.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Video session')),
      ),
      body: IndexPage(),
    );
  }
}
