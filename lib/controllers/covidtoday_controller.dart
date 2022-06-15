import 'package:covid/models/covidtoday_model.dart';
import 'package:covid/services/covidtoday_service.dart';
import 'package:get/get.dart';

class CovidToDayController extends GetxController {
  CovidToDayController(this._service);

  final CovidToDayService _service;
  List<TodayCasesAll> iscovidtoday = <TodayCasesAll>[].obs;
  Future<List<TodayCasesAll>> covidtodayData() async {
    iscovidtoday = await _service.fetchCovidToDay();
    return iscovidtoday;
  }
}
