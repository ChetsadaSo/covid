import 'package:covid/models/covidround3_model.dart';
import 'package:covid/services/covidround3_service.dart';
import 'package:get/get.dart';

class CovidRound3Controller extends GetxController {
  CovidRound3Controller(this._service);

  final CovidRound3Service _service;
  List<TimelineCasesAll> iscovid3 = <TimelineCasesAll>[].obs;
  Future<List<TimelineCasesAll>> covidRound3Data() async {
    iscovid3 = await _service.fetchCovidRound3();
    return iscovid3;
  }
}
