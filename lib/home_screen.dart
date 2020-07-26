import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdoctor/accountpage.dart';
import 'package:flutterdoctor/schedulepage.dart';
import 'package:flutterdoctor/sessionpage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  int _selectedPageIndex = 0;

  var _pages = [
    SessionPage(),
    SchedulePage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home")),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.deepOrange,
                  Colors.orangeAccent,
                ]),
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.circular(50.0),
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/placeholder.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomListTile(Icons.person, 'Profile', () => {}),
            CustomListTile(Icons.settings, 'settings', () => {}),
            CustomListTile(Icons.schedule, 'Appointment', () => {}),
            CustomListTile(Icons.change_history, 'Change Counselor', () => {}),
            CustomListTile(
                Icons.account_balance_wallet, 'Billing Option', () => {}),
            CustomListTile(Icons.contact_phone, 'Contact', () => {}),
            CustomListTile(Icons.lock, 'Log Out', () => {}),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text("Session"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text("Schedule"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Account"),
          ),
        ],
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
        ),
        child: InkWell(
          splashColor: Colors.cyan,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
