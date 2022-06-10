import 'package:covid/views/pages/auth/loginPage.dart';
import 'package:covid/views/pages/homePage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Covid Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginPage(),
    );
  }
}
