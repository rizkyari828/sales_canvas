// To parse this JSON data, do
//
//     final typeLemburResponse = typeLemburResponseFromJson(jsonString);

import 'dart:convert';

TypeLemburResponse typeLemburResponseFromJson(String str) =>
    TypeLemburResponse.fromJson(json.decode(str));

String typeLemburResponseToJson(TypeLemburResponse data) =>
    json.encode(data.toJson());

class TypeLemburResponse {
  TypeLemburResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  String? status;
  String? message;
  bool? error;
  List<DataTypeLembur>? data;

  factory TypeLemburResponse.fromJson(Map<String, dynamic> json) =>
      TypeLemburResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        error: json["error"] == null ? null : json["error"],
        data: json["Data"] == null
            ? null
            : List<DataTypeLembur>.from(
                json["Data"].map((x) => DataTypeLembur.fromJson(x))),
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

class DataTypeLembur {
  DataTypeLembur({
    this.id,
    this.keterangan,
  });

  int? id;
  String? keterangan;

  factory DataTypeLembur.fromJson(Map<String, dynamic> json) => DataTypeLembur(
        id: json["id"] == null ? null : json["id"],
        keterangan: json["keterangan"] == null ? null : json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "keterangan": keterangan == null ? null : keterangan,
      };
}
