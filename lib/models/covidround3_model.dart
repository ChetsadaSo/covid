// To parse this JSON data, do
//
//     final timelineCasesAll = timelineCasesAllFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TimelineCasesAll> timelineCasesAllFromJson(String str) =>
    List<TimelineCasesAll>.from(
        json.decode(str).map((x) => TimelineCasesAll.fromJson(x)));

String timelineCasesAllToJson(List<TimelineCasesAll> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimelineCasesAll {
  TimelineCasesAll({
    required this.txnDate,
    required this.newCase,
    required this.totalCase,
    required this.newCaseExcludeabroad,
    required this.totalCaseExcludeabroad,
    required this.newDeath,
    required this.totalDeath,
    required this.newRecovered,
    required this.totalRecovered,
    required this.updateDate,
  });

  final DateTime txnDate;
  final int newCase;
  final int totalCase;
  final int newCaseExcludeabroad;
  final int totalCaseExcludeabroad;
  final int newDeath;
  final int totalDeath;
  final int newRecovered;
  final int totalRecovered;
  final DateTime updateDate;

  factory TimelineCasesAll.fromJson(Map<String, dynamic> json) =>
      TimelineCasesAll(
        txnDate: DateTime.parse(json["txn_date"]),
        newCase: json["new_case"],
        totalCase: json["total_case"],
        newCaseExcludeabroad: json["new_case_excludeabroad"],
        totalCaseExcludeabroad: json["total_case_excludeabroad"],
        newDeath: json["new_death"],
        totalDeath: json["total_death"],
        newRecovered: json["new_recovered"],
        totalRecovered: json["total_recovered"],
        updateDate: DateTime.parse(json["update_date"]),
      );

  Map<String, dynamic> toJson() => {
        "txn_date":
            "${txnDate.year.toString().padLeft(4, '0')}-${txnDate.month.toString().padLeft(2, '0')}-${txnDate.day.toString().padLeft(2, '0')}",
        "new_case": newCase,
        "total_case": totalCase,
        "new_case_excludeabroad": newCaseExcludeabroad,
        "total_case_excludeabroad": totalCaseExcludeabroad,
        "new_death": newDeath,
        "total_death": totalDeath,
        "new_recovered": newRecovered,
        "total_recovered": totalRecovered,
        "update_date": updateDate.toIso8601String(),
      };
}
