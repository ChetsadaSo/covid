import 'package:covid/views/pages/auth/loginPage.dart';
import 'package:covid/views/pages/daily/dailyCovid.dart';
import 'package:covid/views/pages/homePage/homepage.dart';
import 'package:covid/views/pages/round1to2/round_1to_2.dart';
import 'package:covid/views/pages/round3/round3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class navBar extends StatefulWidget {
  final User user;
  final int pageId;

  navBar(this.user, this.pageId, {Key? key}) : super(key: key);

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  int currentIndex = 0;
  final _auth = FirebaseAuth.instance;
  @override
  initState() {
    super.initState();
  }

  void _onItem(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    currentIndex = currentIndex;
    print(currentIndex);
    final users = widget.user;
    final screens = [
      MyHomePage(users, (int index) {
        _onItem(index);
      }),
      dailyCovids(),
      round1to2(),
      round3(),
    ];
    return Scaffold(
      appBar: appbar(context),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onItem,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 198, 200, 202),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Daily',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airline_stops_outlined),
            label: 'ครั้งแรกและครั้งที่สอง',
            backgroundColor: Color.fromARGB(255, 81, 74, 76),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.moving_outlined),
            label: 'ระบาดครั้งที่สาม',
            backgroundColor: Color.fromARGB(255, 171, 169, 168),
          ),
        ],
      ),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: Colors.black)),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: PopupMenuButton<int>(
              color: Colors.white,
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Profile"),
                ),
                PopupMenuDivider(),
                PopupMenuItem<int>(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text("Logout")
                      ],
                    )),
              ],
              onSelected: (item) => SelectedItem(context, item),
            ),
          ),
        ),
      ],
    );
  }

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        ModalRoute.withName('/'));
  }

  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => SettingPage()));
        break;

      case 1:
        print("User Logged out");
        signOut(context);
        break;
    }
  }
}
