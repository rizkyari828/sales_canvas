// To parse this JSON data, do
//
//     final LeadResponse = LeadResponseFromJson(jsonString);

import 'dart:convert';

LeadResponse LeadResponseFromJson(String str) =>
    LeadResponse.fromJson(json.decode(str));

String LeadResponseToJson(LeadResponse data) => json.encode(data.toJson());

class LeadResponse {
  LeadResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  String? status;
  String? message;
  bool? error;
  List<DataLead>? data;

  factory LeadResponse.fromJson(Map<String, dynamic> json) => LeadResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        error: json["error"] == null ? null : json["error"],
        data: json["Data"] == null
            ? null
            : List<DataLead>.from(
                json["Data"].map((x) => DataLead.fromJson(x))),
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

class DataLead {
  DataLead({
    this.id,
    this.kodeIjin,
    this.dateIn,
    this.dateOut,
    this.keterangan,
    this.cDate,
  });

  int? id;
  String? kodeIjin;
  DateTime? dateIn;
  DateTime? dateOut;
  DateTime? cDate;
  String? keterangan;

  factory DataLead.fromJson(Map<String, dynamic> json) => DataLead(
        id: json["id"] == null ? null : json["id"],
        kodeIjin: json["kode_ijin"] == null ? null : json["kode_ijin"],
        dateIn:
            json["date_in"] == null ? null : DateTime.parse(json["date_in"]),
        dateOut:
            json["date_out"] == null ? null : DateTime.parse(json["date_out"]),
        cDate: json["c_date"] == null ? null : DateTime.parse(json["c_date"]),
        keterangan: json["keterangan"] == null ? null : json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "kode_ijin": kodeIjin == null ? null : kodeIjin,
        "date_in": dateIn == null
            ? null
            : "${dateIn?.year.toString().padLeft(4, '0')}-${dateIn?.month.toString().padLeft(2, '0')}-${dateIn?.day.toString().padLeft(2, '0')}",
        "date_out": dateOut == null
            ? null
            : "${dateOut?.year.toString().padLeft(4, '0')}-${dateOut?.month.toString().padLeft(2, '0')}-${dateOut?.day.toString().padLeft(2, '0')}",
        "c_date": cDate == null
            ? null
            : "${cDate?.year.toString().padLeft(4, '0')}-${cDate?.month.toString().padLeft(2, '0')}-${cDate?.day.toString().padLeft(2, '0')}",
        "keterangan": keterangan == null ? null : keterangan,
      };
}
