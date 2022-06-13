import 'package:covid/views/navBar/navbar.dart';
import 'package:covid/views/pages/auth/loginPage.dart';
import 'package:covid/views/pages/daily/dailyCovid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  final User user;
  final VoidCallback _onItem;
  MyHomePage(this.user, this._onItem, {Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User users = widget.user;
    // Id of the provider (ex: google.com)
    String name = widget.user.displayName.toString();
    String email = users.email.toString();
    String photoUrl = users.photoURL.toString();
    String uid = users.uid.toString();
    return Scaffold(
      body: body(
        photoUrl,
        name,
        email,
      ),
    );
  }

  SafeArea body(
    String photoUrl,
    String name,
    String email,
  ) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          avatar(photoUrl),
          SizedBox(),
          nameUser(name),
          emailUser(email),
          SizedBox(
            height: 40,
          ),
          dailyCovid(),
          SizedBox(
            height: 20,
          ),
          rippleOfCovid(),
        ],
      ),
    );
  }

  Center rippleOfCovid() {
    return Center(
      child: Column(
        children: [
          ripple1(),
          ripple2(),
          ripple3(),
        ],
      ),
    );
  }

  Padding ripple3() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 5, 10),
      child: Container(
        width: 300,
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: InkWell(
          onDoubleTap: () {
            print('object4');
          },
          child: Container(
            // margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(25),
            child: Center(child: Text('สถานการณ์การระบาดรอบที่สาม')),
            width: 300,
            height: 100,
          ),
        ),
      ),
    );
  }

  Padding ripple2() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 10),
      child: Container(
        width: 300,
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
          shape: BoxShape.rectangle,
        ),
        child: InkWell(
          onDoubleTap: () {
            print('object3');
          },
          child: Container(
            // margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(25),
            child: Center(child: Text('สถานการณ์การระบาดรอที่สอง')),
            width: 300,
            height: 100,
          ),
        ),
      ),
    );
  }

  Padding ripple1() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 5, 10),
      child: Container(
        width: 300,
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: InkWell(
          onDoubleTap: () {
            print('object2');
          },
          child: Container(
            // margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(25),
            child: Center(child: Text('สถานการณ์การระบาดรอบแรก')),
            width: 300,
            height: 100,
          ),
        ),
      ),
    );
  }

  Container dailyCovid() {
    return Container(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(221, 197, 255, 155),
            Color.fromARGB(255, 246, 247, 245)
          ],
        ),
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: InkWell(
        onDoubleTap: () {
          widget._onItem();
          print('object');
        },
        child: Container(
          // margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(25),
          child: Center(child: Text('รายงานประจำวัน')),
          width: 300,
          height: 100,
        ),
      ),
    );
  }

  Padding emailUser(String email) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: Text(
          email,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Padding nameUser(String name) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
        child: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Align avatar(String photoUrl) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 16, 0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
            child: Container(
              width: 60,
              height: 60,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                photoUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
