import 'package:covid/views/pages/auth/loginPage.dart';
import 'package:covid/views/pages/daily/dailyCovid.dart';
import 'package:covid/views/pages/homePage/homepage.dart';
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

  Future<void> _refresh() async {
    setState(() {
      LoginPage();
    });
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
      Center(
        child: Text(
          'Haha',
          style: TextStyle(fontSize: 60),
        ),
      ),
      Center(
        child: Text(
          'hehe',
          style: TextStyle(fontSize: 60),
        ),
      ),
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
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Daily',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.one_k),
            label: 'Covid1',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.two_k),
            label: 'Covid2',
            backgroundColor: Colors.red,
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
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Refresh"),
                ),
                PopupMenuDivider(),
                PopupMenuItem<int>(
                    value: 2,
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
        _refresh();
        break;
      case 2:
        print("User Logged out");
        signOut(context);
        break;
    }
  }
}
