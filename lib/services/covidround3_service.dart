import 'dart:convert';

import 'package:covid/models/covidround3_model.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class CovidRound3Service extends GetxController {
  Future<List<TimelineCasesAll>> fetchCovidRound3() async {
    var url = Uri.parse(
        'https://covid19.ddc.moph.go.th/api/Cases/timeline-cases-all');
    var response = await http.get(url);
    return timelineCasesAllFromJson(response.body);
  }
}
