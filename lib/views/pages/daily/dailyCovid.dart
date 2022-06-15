import 'package:covid/config/size.dart';
import 'package:covid/controllers/covidtoday_controller.dart';
import 'package:covid/models/covidtoday_model.dart';
import 'package:covid/services/covidtoday_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class dailyCovids extends StatefulWidget {
  dailyCovids({Key? key}) : super(key: key);

  @override
  State<dailyCovids> createState() => _dailyCovidState();
}

class _dailyCovidState extends State<dailyCovids> {
  final CovidToDayController _controller =
      Get.put(CovidToDayController(CovidToDayService()));
  var covidControl;

  @override
  void initState() {
    super.initState();
    covidControl = _controller.covidtodayData();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
      covidControl = _controller.covidtodayData();
    });
  }

  var formatter = DateFormat.yMMMMEEEEd('th');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder<List<TodayCasesAll>>(
            future: covidControl,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                print(_controller.iscovidtoday.length);
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                      itemCount: _controller.iscovidtoday.length,
                      itemBuilder: (context, index) {
                        List<TodayCasesAll> covidtoday =
                            _controller.iscovidtoday;
                        return detailCovidtoday(covidtoday, index);
                      }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Center detailCovidtoday(List<TodayCasesAll> covidtoday, int index) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: getScreenHeight(50)),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    "ข้อมูลโควิด",
                    style: TextStyle(fontSize: getScreenHeight(40)),
                  ),
                  Text(
                    formatter.format(covidtoday[index].txnDate),
                    style: TextStyle(fontSize: getScreenHeight(20)),
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                height: getScreenHeight(350),
                padding: EdgeInsets.all(getScreenHeight(10)),
                // color: Color.fromARGB(255, 255, 218, 218),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            CaseCovid(covidtoday, index),
                            SizedBox(
                              height: getScreenHeight(10),
                            ),
                            deadCovidtoday(covidtoday, index),
                          ],
                        ),
                        SizedBox(
                          width: getScreenWidth(10),
                        ),
                        Column(
                          children: [
                            deadCovidSum(covidtoday, index),
                            SizedBox(
                              height: getScreenHeight(10),
                            ),
                            newRecovered(covidtoday, index),
                            SizedBox(
                              height: getScreenHeight(10),
                            ),
                            recoveredSum(covidtoday, index),
                          ],
                        ),
                      ],
                    ),
                    Text("อัพเดตล่าสุด:" +
                        " " +
                        covidtoday[index].updateDate.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container recoveredSum(List<TodayCasesAll> covidtoday, int index) {
    return Container(
      height: getScreenHeight(80),
      width: getScreenWidth(200),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 0, 76, 36),
          Color.fromARGB(255, 51, 255, 41),
        ]),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                getScreenWidth(20), getScreenHeight(10), 0, 0),
            child: Text(
              "รักษาหายสะสม",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: getScreenHeight(15),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            NumberFormat("#,###").format(covidtoday[index].totalRecovered) +
                " " +
                "คน",
            style: TextStyle(
                color: Colors.white,
                fontSize: getScreenHeight(30),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Container newRecovered(List<TodayCasesAll> covidtoday, int index) {
    return Container(
      height: getScreenHeight(80),
      width: getScreenWidth(200),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 69, 217, 163),
          Color.fromARGB(255, 216, 246, 225),
        ]),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                getScreenWidth(50), getScreenHeight(10), 0, 0),
            child: Text(
              "รักษาหาย",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: getScreenHeight(15),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            NumberFormat("#,###").format(covidtoday[index].newRecovered) +
                " คน",
            style: TextStyle(
                color: Colors.white,
                fontSize: getScreenHeight(35),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Container deadCovidSum(List<TodayCasesAll> covidtoday, int index) {
    return Container(
      height: getScreenHeight(80),
      width: getScreenWidth(200),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 223, 219, 219),
        ]),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                getScreenWidth(50), getScreenHeight(10), 0, 0),
            child: Text(
              "ยอดผู้เสียชีวิตสะสม",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: getScreenHeight(15),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            NumberFormat("#,###").format(covidtoday[index].totalDeath) + " คน",
            style: TextStyle(
                color: Colors.white,
                fontSize: getScreenHeight(35),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Container deadCovidtoday(List<TodayCasesAll> covidtoday, int index) {
    return Container(
      height: getScreenHeight(80),
      width: getScreenWidth(180),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 124, 120, 120),
          Color.fromARGB(255, 223, 219, 219)
        ]),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                getScreenWidth(20), getScreenHeight(5), 0, 0),
            child: Text(
              "ยอดผู้เสียชีวิตวันนี้",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: getScreenHeight(15),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(getScreenWidth(50), 0, 0, 0),
            child: Text(
              covidtoday[index].newDeath.toString() + " คน",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: getScreenHeight(35),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Container CaseCovid(List<TodayCasesAll> covidtoday, int index) {
    return Container(
      height: getScreenHeight(180),
      width: getScreenWidth(180),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 227, 79, 79),
          Color.fromARGB(255, 247, 213, 213)
        ]),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                0, getScreenHeight(10), 0, getScreenHeight(10)),
            child: Text(
              "ยอดผู้ติดเชื้อวันนี้",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: getScreenHeight(20),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            NumberFormat("#,###").format(covidtoday[index].newCase),
            style: TextStyle(
                color: Colors.white,
                fontSize: getScreenHeight(50),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: getScreenHeight(10),
          ),
          Container(
            margin: EdgeInsets.only(left: getScreenWidth(80)),
            child: Text("สะสม",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getScreenHeight(20),
                    fontWeight: FontWeight.bold)),
          ),
          Text(
              "  " +
                  NumberFormat("#,###").format(covidtoday[index].totalCase) +
                  "  " +
                  "คน",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: getScreenHeight(20),
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
