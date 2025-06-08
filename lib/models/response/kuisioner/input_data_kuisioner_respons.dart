// To parse this JSON data, do
//
//     final inputDataKuisionerRespons = inputDataKuisionerResponsFromJson(jsonString);

import 'dart:convert';

InputDataKuisionerRespons inputDataKuisionerResponsFromJson(String str) =>
    InputDataKuisionerRespons.fromJson(json.decode(str));

String inputDataKuisionerResponsToJson(InputDataKuisionerRespons data) =>
    json.encode(data.toJson());

class InputDataKuisionerRespons {
  String? status;
  String? message;
  bool? error;
  List<DataSummaryKuisioner>? data;

  InputDataKuisionerRespons({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory InputDataKuisionerRespons.fromJson(Map<String, dynamic> json) =>
      InputDataKuisionerRespons(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<DataSummaryKuisioner>.from(
                json["Data"]!.map((x) => DataSummaryKuisioner.fromJson(x))),
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

class DataSummaryKuisioner {
  int? idTrans;
  int? idGroup;
  int? jumlahSoal;

  DataSummaryKuisioner({
    this.idTrans,
    this.idGroup,
    this.jumlahSoal,
  });

  factory DataSummaryKuisioner.fromJson(Map<String, dynamic> json) =>
      DataSummaryKuisioner(
        idTrans: json["id_trans"],
        idGroup: json["id_group   "],
        jumlahSoal: json["jumlah_soal"],
      );

  Map<String, dynamic> toJson() => {
        "id_trans": idTrans,
        "id_group   ": idGroup,
        "jumlah_soal": jumlahSoal,
      };
}
