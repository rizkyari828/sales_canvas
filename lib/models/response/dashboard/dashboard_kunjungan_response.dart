// To parse this JSON data, do
//
//     final DashboardKunjunganResponse = DashboardKunjunganResponseFromJson(jsonString);

import 'dart:convert';

DashboardKunjunganResponse dashboardKunjunganResponseFromJson(String str) =>
    DashboardKunjunganResponse.fromJson(json.decode(str));

String dashboardKunjunganResponseToJson(DashboardKunjunganResponse data) =>
    json.encode(data.toJson());

class DashboardKunjunganResponse {
  String? status;
  String? message;
  bool? error;
  List<DashbooardKunjunganData>? data;

  DashboardKunjunganResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory DashboardKunjunganResponse.fromJson(Map<String, dynamic> json) =>
      DashboardKunjunganResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<DashbooardKunjunganData>.from(
                json["Data"]!.map((x) => DashbooardKunjunganData.fromJson(x))),
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

class DashbooardKunjunganData {
  int? count;

  DashbooardKunjunganData({
    this.count,
  });

  factory DashbooardKunjunganData.fromJson(Map<String, dynamic> json) =>
      DashbooardKunjunganData(
        count: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "jumlah": count,
      };
}
