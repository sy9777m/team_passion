import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:team_passion/module/m_firebase.dart';
import 'package:team_passion/screen/homepage/s_add_goal.dart';
import 'package:team_passion/screen/homepage/s_community_screen.dart';
import 'package:team_passion/screen/homepage/s_home_screen.dart';
import 'package:team_passion/screen/homepage/s_my_screen.dart';

class Home extends StatefulWidget {
  static String id = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CommunityScreen(),
    MyScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FireBaseModule>(builder: (context, firebaseModule, child) {
      return StreamBuilder<DocumentSnapshot>(
          stream: firebaseModule.getUserSnapshot(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Scaffold(
                key: _scaffoldKey,
                body: SafeArea(
                  child: Center(
                    child: _widgetOptions.elementAt(_selectedIndex),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(FontAwesomeIcons.plus),
                  onPressed: () => Navigator.pushNamed(context, AddGoalPage.id),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 10.0,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.home),
                      title: Container(),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.users),
                      title: Container(),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.user),
                      title: Container(),
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
              );
            }
          });
    });
  }
}
