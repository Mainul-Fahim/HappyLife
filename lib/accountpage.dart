import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  void fetchUserData() async {
    FirebaseUser u = await _auth.currentUser();
    setState(() {
      _user = u;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: _user != null
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FadeInImage(
                      width: 150,
                      height: 150,
                      image: NetworkImage("${_user.photoUrl}"),
                      placeholder: AssetImage("assets/placeholder.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("${_user.displayName}"),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      _auth.signOut();
                    },
                    child: Text("Logout"),
                  ),
                ],
              )
            : LinearProgressIndicator(),
      ),
    );
  }
}
