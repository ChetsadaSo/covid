import 'dart:convert';

import 'package:covid/models/covidtoday_model.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class CovidToDayService extends GetxController {
  Future<List<TodayCasesAll>> fetchCovidToDay() async {
    var url =
        Uri.parse('https://covid19.ddc.moph.go.th/api/Cases/today-cases-all');
    var response = await http.get(url);
    return todayCasesAllFromJson(response.body);
  }
}
