import 'package:covid/views/pages/auth/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final User user;

  MyHomePage(this.user, {Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Colors.black,
              onPressed: () {
                signOut(context);
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Hello", style: TextStyle(fontSize: 26)),
            Text(widget.user.uid, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        ModalRoute.withName('/'));
  }
}
