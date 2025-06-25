// To parse this JSON data, do
//
//     final lemburResponse = lemburResponseFromJson(jsonString);

import 'dart:convert';

LemburResponse lemburResponseFromJson(String str) =>
    LemburResponse.fromJson(json.decode(str));

String lemburResponseToJson(LemburResponse data) => json.encode(data.toJson());

class LemburResponse {
  String? status;
  String? message;
  bool? error;
  List<DataLembur>? data;

  LemburResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory LemburResponse.fromJson(Map<String, dynamic> json) => LemburResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<DataLembur>.from(
                json["Data"]!.map((x) => DataLembur.fromJson(x))),
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

class DataLembur {
  DateTime? tanggalLembur;
  String? jamIn;
  String? jamOut;
  String? statusLembur;
  String? user;
  int? idLembur;

  DataLembur({
    this.tanggalLembur,
    this.jamIn,
    this.jamOut,
    this.statusLembur,
    this.user,
    this.idLembur,
  });

  factory DataLembur.fromJson(Map<String, dynamic> json) => DataLembur(
        tanggalLembur: json["tanggal_lembur"] == null
            ? null
            : DateTime.parse(json["tanggal_lembur"]),
        jamIn: json["jam_in"],
        jamOut: json["jam_out"],
        statusLembur: json["status_lembur"],
        user: json["user"],
        idLembur: json["id_lembur"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal_lembur":
            "${tanggalLembur!.year.toString().padLeft(4, '0')}-${tanggalLembur!.month.toString().padLeft(2, '0')}-${tanggalLembur!.day.toString().padLeft(2, '0')}",
        "jam_in": jamIn,
        "jam_out": jamOut,
        "status_lembur": statusLembur,
        "user": user,
        "id_lembur": idLembur,
      };
}
