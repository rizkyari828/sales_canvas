// To parse this JSON data, do
//
//     final listKuisionerRespons = listKuisionerResponsFromJson(jsonString);

import 'dart:convert';

ListKuisionerRespons listKuisionerResponsFromJson(String str) =>
    ListKuisionerRespons.fromJson(json.decode(str));

String listKuisionerResponsToJson(ListKuisionerRespons data) =>
    json.encode(data.toJson());

class ListKuisionerRespons {
  String? status;
  String? message;
  bool? error;
  List<DataKuisioner>? data;

  ListKuisionerRespons({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory ListKuisionerRespons.fromJson(Map<String, dynamic> json) =>
      ListKuisionerRespons(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<DataKuisioner>.from(
                json["Data"]!.map((x) => DataKuisioner.fromJson(x))),
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

class DataKuisioner {
  int? no;
  int? idSoal;
  int? idKategori;
  String? soal;
  String? pilihan1;
  String? pilihan2;
  String? pilihan3;
  String? pilihan4;

  DataKuisioner({
    this.no,
    this.idSoal,
    this.idKategori,
    this.soal,
    this.pilihan1,
    this.pilihan2,
    this.pilihan3,
    this.pilihan4,
  });

  factory DataKuisioner.fromJson(Map<String, dynamic> json) => DataKuisioner(
        no: json["no"],
        idSoal: json["id_soal"],
        idKategori: json["id_kategori"],
        soal: json["soal"],
        pilihan1: json["pilihan_1"],
        pilihan2: json["pilihan_2"],
        pilihan3: json["pilihan_3"],
        pilihan4: json["pilihan_4"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "id_soal": idSoal,
        "id_kategori": idKategori,
        "soal": soal,
        "pilihan_1": pilihan1,
        "pilihan_2": pilihan2,
        "pilihan_3": pilihan3,
        "pilihan_4": pilihan4,
      };
}
