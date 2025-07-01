// To parse this JSON data, do
//
//     final DashboardResponse = DashboardResponseFromJson(jsonString);

import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) =>
    DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) =>
    json.encode(data.toJson());

class DashboardResponse {
  String? status;
  String? message;
  bool? error;
  List<DashbooardData>? data;

  DashboardResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      DashboardResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<DashbooardData>.from(
                json["Data"]!.map((x) => DashbooardData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "Data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DashbooardData {
  int? dailyActualProgress;
  int? dailyPlanProgress;
  int? dailyPercentageProgress;
  int? monthlyActualAttendance;
  int? monthlyPlanAttendance;
  int? monthlyPercentageAttendance;

  DashbooardData(
      {this.dailyActualProgress,
      this.dailyPlanProgress,
      this.dailyPercentageProgress,
      this.monthlyActualAttendance,
      this.monthlyPlanAttendance,
      this.monthlyPercentageAttendance});

  factory DashbooardData.fromJson(Map<String, dynamic> json) => DashbooardData(
        dailyActualProgress: json["status_cuti"],
        dailyPlanProgress: json["user"],
        dailyPercentageProgress: json["keperluan"],
        monthlyActualAttendance: json["level"],
        monthlyPlanAttendance: json["level"],
        monthlyPercentageAttendance: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "status_cuti": dailyActualProgress,
        "user": dailyPlanProgress,
        "keperluan": dailyPercentageProgress,
        "level": monthlyActualAttendance,
        "level2": monthlyPlanAttendance,
        "level3": monthlyPercentageAttendance,
      };
}
