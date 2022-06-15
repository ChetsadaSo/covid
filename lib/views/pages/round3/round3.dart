import 'package:covid/controllers/covidround3_controller.dart';
import 'package:covid/models/covidround3_model.dart';

import 'package:covid/services/covidround3_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class round3 extends StatefulWidget {
  round3({Key? key}) : super(key: key);

  @override
  State<round3> createState() => _round3State();
}

class _round3State extends State<round3> {
  var formatter = DateFormat.yMMMd('th');
  final CovidRound3Controller _controller =
      Get.put(CovidRound3Controller(CovidRound3Service()));
  var covidControl;

  @override
  void initState() {
    super.initState();
    covidControl = _controller.covidRound3Data();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
      covidControl = _controller.covidRound3Data();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder<List<TimelineCasesAll>>(
            future: covidControl,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                print(_controller.iscovid3.length);
                List<TimelineCasesAll> covid1to2 = _controller.iscovid3;
                var sumcase = covid1to2[covid1to2.length - 1].totalCase;
                var sumDeath = covid1to2[covid1to2.length - 1].totalDeath;
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(children: [
                    Column(
                      children: [
                        Container(
                          child: Text(
                            "สถานการณ์โควิดระลอกสาม",
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
                                  ColumnSeries<ChartData, String>(
                                      dataSource: [
                                        for (var i = 0;
                                            i < covid1to2.length;
                                            i++)
                                          ChartData(
                                            formatter
                                                .format(covid1to2[i].txnDate)
                                                .toString(),
                                            covid1to2[i].newDeath.toDouble(),
                                            Color.fromARGB(255,
                                                covid1to2[i].newDeath, 0, 0),
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
