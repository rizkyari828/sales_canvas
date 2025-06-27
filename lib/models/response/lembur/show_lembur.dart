// To parse this JSON data, do
//
//     final showLemburResponse = showLemburResponseFromJson(jsonString);

import 'dart:convert';

ShowLemburResponse showLemburResponseFromJson(String str) =>
    ShowLemburResponse.fromJson(json.decode(str));

String showLemburResponseToJson(ShowLemburResponse data) =>
    json.encode(data.toJson());

class ShowLemburResponse {
  String? status;
  String? message;
  bool? error;
  List<ShowDataLembur>? data;

  ShowLemburResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory ShowLemburResponse.fromJson(Map<String, dynamic> json) =>
      ShowLemburResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<ShowDataLembur>.from(
                json["Data"]!.map((x) => ShowDataLembur.fromJson(x))),
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

class ShowDataLembur {
  DateTime? tanggalLembur;
  String? jamIn;
  String? jamOut;
  String? statusLembur;
  int? idLembur;
  String? user;
  String? keperluan;

  ShowDataLembur({
    this.tanggalLembur,
    this.jamIn,
    this.jamOut,
    this.statusLembur,
    this.idLembur,
    this.user,
    this.keperluan,
  });

  factory ShowDataLembur.fromJson(Map<String, dynamic> json) => ShowDataLembur(
        tanggalLembur: json["tanggal_lembur"] == null
            ? null
            : DateTime.parse(json["tanggal_lembur"]),
        jamIn: json["jam_in"],
        jamOut: json["jam_out"],
        statusLembur: json["status_lembur"],
        idLembur: json["id_lembur"],
        user: json["user"],
        keperluan: json["keperluan"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal_lembur":
            "${tanggalLembur!.year.toString().padLeft(4, '0')}-${tanggalLembur!.month.toString().padLeft(2, '0')}-${tanggalLembur!.day.toString().padLeft(2, '0')}",
        "jam_in": jamIn,
        "jam_out": jamOut,
        "status_lembur": statusLembur,
        "id_lembur": idLembur,
        "user": user,
        "keperluan": keperluan,
      };
}
