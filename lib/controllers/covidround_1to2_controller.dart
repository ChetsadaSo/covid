import 'package:covid/models/covidround_1to2_model.dart';
import 'package:covid/services/covidround_1to2_service.dart';
import 'package:get/get.dart';

class CovidRound1To2Controller extends GetxController {
  CovidRound1To2Controller(this._service);

  final CovidRound1To2Service _service;
  List<Round1To2All> iscovid1to2 = <Round1To2All>[].obs;
  Future<List<Round1To2All>> covidRound1To2Data() async {
    iscovid1to2 = await _service.fetchCovidRound1To2();
    return iscovid1to2;
  }
}
