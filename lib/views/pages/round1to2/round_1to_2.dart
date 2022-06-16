import 'package:covid/config/size.dart';
import 'package:covid/controllers/covidround_1to2_controller.dart';
import 'package:covid/models/covidround_1to2_model.dart';
import 'package:covid/services/covidround_1to2_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class round1to2 extends StatefulWidget {
  round1to2({Key? key}) : super(key: key);

  @override
  State<round1to2> createState() => _round1to2State();
}

class _round1to2State extends State<round1to2> {
  var formatter = DateFormat.yMMMd();
  final CovidRound1To2Controller _controller =
      Get.put(CovidRound1To2Controller(CovidRound1To2Service()));
  var covidControl;

  @override
  void initState() {
    super.initState();
    covidControl = _controller.covidRound1To2Data();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
      covidControl = _controller.covidRound1To2Data();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder<List<Round1To2All>>(
            future: covidControl,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                print(_controller.iscovid1to2.length);
                List<Round1To2All> covid1to2 = _controller.iscovid1to2;
                var sumcase = covid1to2[covid1to2.length - 1].totalCase;
                var sumDeath = covid1to2[covid1to2.length - 1].totalDeath;
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(children: [
                    Column(
                      children: [
                        Container(
                          child: Text(
                            "สถานการณ์โควิดระลอกแรกและสอง",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 5),
                          child: Text(
                            "ภาพรวมผู้ติดเชื้อจำนวนทั้งหมด " +
                                NumberFormat("#,###").format(sumcase) +
                                " คน",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: <ChartSeries>[
                              LineSeries<ChartData, String>(
                                  dataSource: [
                                    for (var i = 0; i < covid1to2.length; i++)
                                      ChartData(
                                        formatter
                                            .format(covid1to2[i].txnDate)
                                            .toString(),
                                        covid1to2[i].newCase.toDouble(),
                                        Color.fromARGB(
                                            255,
                                            covid1to2[i].newCase,
                                            255 - (covid1to2[i].newCase - 100),
                                            0),
                                      ),
                                  ],
                                  // Bind the color for all the data points from the data source
                                  pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(getScreenHeight(10)),
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 100, 5),
                          child: Text(
                            "ภาพรวมผู้เสียชีวิตจำนวนทั้งหมด " +
                                NumberFormat("#,###").format(sumDeath) +
                                " คน",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                series: <ChartSeries>[
                                  BarSeries<ChartData, String>(
                                      dataSource: [
                                        for (var i = 0;
                                            i < covid1to2.length;
                                            i++)
                                          ChartData(
                                            formatter
                                                .format(covid1to2[i].txnDate)
                                                .toString(),
                                            covid1to2[i].newDeath.toDouble(),
                                            Color.fromARGB(
                                                255,
                                                covid1to2[i].newDeath + 200,
                                                0,
                                                0),
                                          ),
                                      ],
                                      pointColorMapper: (ChartData data, _) =>
                                          data.color,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y)
                                ]))
                      ],
                    ),
                  ]),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
