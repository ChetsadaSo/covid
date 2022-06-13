import 'package:flutter/material.dart';

class dailyCovids extends StatefulWidget {
  dailyCovids({Key? key}) : super(key: key);

  @override
  State<dailyCovids> createState() => _dailyCovidState();
}

class _dailyCovidState extends State<dailyCovids> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Text("โควิดรายวัน"),
        ),
      ),
    );
  }
}
