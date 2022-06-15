import 'dart:convert';

import 'package:covid/models/covidround_1to2_model.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class CovidRound1To2Service extends GetxController {
  Future<List<Round1To2All>> fetchCovidRound1To2() async {
    var url =
        Uri.parse('https://covid19.ddc.moph.go.th/api/Cases/round-1to2-all');
    var response = await http.get(url);
    return round1To2AllFromJson(response.body);
  }
}
