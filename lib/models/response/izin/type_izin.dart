// To parse this JSON data, do
//
//     final typeIzinResponse = typeIzinResponseFromJson(jsonString);

import 'dart:convert';

TypeIzinResponse typeIzinResponseFromJson(String str) =>
    TypeIzinResponse.fromJson(json.decode(str));

String typeIzinResponseToJson(TypeIzinResponse data) =>
    json.encode(data.toJson());

class TypeIzinResponse {
  TypeIzinResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  String? status;
  String? message;
  bool? error;
  List<DataTypeIzin>? data;

  factory TypeIzinResponse.fromJson(Map<String, dynamic> json) =>
      TypeIzinResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        error: json["error"] == null ? null : json["error"],
        data: json["Data"] == null
            ? null
            : List<DataTypeIzin>.from(
                json["Data"].map((x) => DataTypeIzin.fromJson(x))),
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

class DataTypeIzin {
  DataTypeIzin({
    this.id,
    this.keterangan,
  });

  int? id;
  String? keterangan;

  factory DataTypeIzin.fromJson(Map<String, dynamic> json) => DataTypeIzin(
        id: json["id"] == null ? null : json["id"],
        keterangan: json["keterangan"] == null ? null : json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "keterangan": keterangan == null ? null : keterangan,
      };
}
