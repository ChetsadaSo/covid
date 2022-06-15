import 'dart:ffi';

import 'package:covid/config/size.dart';
import 'package:covid/views/navBar/navbar.dart';
import 'package:covid/views/pages/auth/loginPage.dart';
import 'package:covid/views/pages/daily/dailyCovid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef Int2VoidFunc = void Function(int);

class MyHomePage extends StatefulWidget {
  final User user;
  final Int2VoidFunc _onItem;
  MyHomePage(this.user, this._onItem, {Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User users = widget.user;
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
          SizedBox(
            height: getScreenHeight(20),
          ),
          avatar(photoUrl),
          SizedBox(
            height: getScreenHeight(20),
          ),
          nameUser(name),
          emailUser(email),
          SizedBox(
            height: getScreenHeight(40),
          ),
          dailyCovid(),
          SizedBox(
            height: getScreenHeight(20),
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
          ripple1to2(),
          ripple3(),
        ],
      ),
    );
  }

  Padding ripple3() {
    return Padding(
      padding: EdgeInsetsDirectional.all(getScreenHeight(20)),
      child: Container(
        width: getScreenWidth(300),
        height: getScreenHeight(70),
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: InkWell(
          onDoubleTap: () {
            widget._onItem(3);
          },
          child: Container(
            // margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(getScreenHeight(25)),
            child: Center(child: Text('สถานการณ์การระบาดรอบที่สาม')),
            width: getScreenWidth(300),
            height: getScreenHeight(100),
          ),
        ),
      ),
    );
  }

  Padding ripple1to2() {
    return Padding(
      padding: EdgeInsetsDirectional.all(getScreenHeight(20)),
      child: Container(
        width: getScreenWidth(300),
        height: getScreenHeight(70),
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        child: InkWell(
          onDoubleTap: () {
            widget._onItem(2);
          },
          child: Container(
            // margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(getScreenHeight(25)),
            child: Center(child: Text('สถานการณ์การระบาดรอบแรก')),
            width: getScreenWidth(300),
            height: getScreenHeight(100),
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
          widget._onItem(1);
        },
        child: Container(
          // margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(getScreenHeight(25)),
          child: Center(child: Text('รายงานประจำวัน')),
          width: getScreenWidth(300),
          height: getScreenHeight(100),
        ),
      ),
    );
  }

  Padding emailUser(String email) {
    return Padding(
      padding: EdgeInsetsDirectional.all(getScreenHeight(10)),
      child: Text(
        email,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Padding nameUser(String name) {
    if (name == null) {
      name = "Full name";
    }
    ;
    return Padding(
      padding: EdgeInsetsDirectional.all(getScreenHeight(10)),
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Align avatar(String photoUrl) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.all(getScreenHeight(10)),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.all(getScreenHeight(1)),
            child: Container(
              width: getScreenWidth(80),
              height: getScreenHeight(80),
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
