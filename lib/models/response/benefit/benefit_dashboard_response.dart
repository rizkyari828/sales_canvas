// To parse this JSON data, do
//
//     final benefitDashboardResponse = benefitDashboardResponseFromJson(jsonString);

import 'dart:convert';

BenefitDashboardResponse benefitDashboardResponseFromJson(String str) =>
    BenefitDashboardResponse.fromJson(json.decode(str));

String benefitDashboardResponseToJson(BenefitDashboardResponse data) =>
    json.encode(data.toJson());

class BenefitDashboardResponse {
  BenefitDashboardResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  String? status;
  String? message;
  bool? error;
  List<DataBenefitDashboard>? data;

  factory BenefitDashboardResponse.fromJson(Map<String, dynamic> json) =>
      BenefitDashboardResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        error: json["error"] == null ? null : json["error"],
        data: json["Data"] == null
            ? null
            : List<DataBenefitDashboard>.from(
                json["Data"].map((x) => DataBenefitDashboard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "error": error == null ? null : error,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataBenefitDashboard {
  DataBenefitDashboard(
      {this.jumlahBoking,
      this.nominal,
      this.jumlahBulanLalu,
      this.jumlahBulanIni,
      this.event});

  String? jumlahBoking;
  String? nominal;
  String? jumlahBulanLalu;
  String? jumlahBulanIni;
  String? event;

  factory DataBenefitDashboard.fromJson(Map<String, dynamic> json) =>
      DataBenefitDashboard(
          jumlahBoking:
              json["jumlah_boking"] == null ? null : json["jumlah_boking"],
          nominal: json["Nominal"] == null ? null : json["Nominal"],
          jumlahBulanLalu: json["jumlah_bulan_lalu"] == null
              ? null
              : json["jumlah_bulan_lalu"],
          jumlahBulanIni: json["jumlah_bulan_ini"] == null
              ? null
              : json["jumlah_bulan_ini"],
          event: json["event"] == null ? null : json["event"]);

  Map<String, dynamic> toJson() => {
        "jumlah_boking": jumlahBoking == null ? null : jumlahBoking,
        "Nominal": nominal == null ? null : nominal,
        "jumlah_bulan_lalu": jumlahBulanLalu == null ? null : jumlahBulanLalu,
        "jumlah_bulan_ini": jumlahBulanIni == null ? null : jumlahBulanIni,
        "event_hari_ini": event == null ? null : event,
      };
}
