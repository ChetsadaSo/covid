// To parse this JSON data, do
//
//     final round1To2All = round1To2AllFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Round1To2All> round1To2AllFromJson(String str) => List<Round1To2All>.from(
    json.decode(str).map((x) => Round1To2All.fromJson(x)));

String round1To2AllToJson(List<Round1To2All> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Round1To2All {
  Round1To2All({
    required this.txnDate,
    required this.newCase,
    required this.totalCase,
    required this.newCaseExcludeabroad,
    required this.totalCaseExcludeabroad,
    required this.newDeath,
    required this.totalDeath,
    required this.newRecovered,
    required this.totalRecovered,
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

  factory Round1To2All.fromJson(Map<String, dynamic> json) => Round1To2All(
        txnDate: DateTime.parse(json["txn_date"]),
        newCase: json["new_case"],
        totalCase: json["total_case"],
        newCaseExcludeabroad: json["new_case_excludeabroad"],
        totalCaseExcludeabroad: json["total_case_excludeabroad"],
        newDeath: json["new_death"],
        totalDeath: json["total_death"],
        newRecovered: json["new_recovered"],
        totalRecovered: json["total_recovered"],
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
      };
}
