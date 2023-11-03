import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:skillss/bages/formStart/view.dart';
import 'package:skillss/bages/jobs/view.dart';

import '../home/view.dart';

//////mor
class MainNav extends StatefulWidget {
  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Jobs(),
    FormStart(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff041038),
      /*
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70.0,
              height: 23,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/image/tamiText.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Color(0xFF1E3799),
        automaticallyImplyLeading: false,
      ),

       */
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Color(0xff041038),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.white,
              hoverColor: Colors.white,
              gap: 8,
              activeColor: Colors.white.withOpacity(1),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.orange,
              color: Colors.orange,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.badge_outlined,
                  text: 'Jobs',
                ),

                GButton(
                  icon: Icons.add_box,
                  text: 'Add',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'person',
                ),


              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}