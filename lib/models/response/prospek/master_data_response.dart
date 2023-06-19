// To parse this JSON data, do
//
//     final masterDataProspekResponse = masterDataProspekResponseFromJson(jsonString);

import 'dart:convert';

MasterDataProspekResponse masterDataProspekResponseFromJson(String str) =>
    MasterDataProspekResponse.fromJson(json.decode(str));

String masterDataProspekResponseToJson(MasterDataProspekResponse data) =>
    json.encode(data.toJson());

class MasterDataProspekResponse {
  MasterDataProspekResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<MasterData>? data;

  factory MasterDataProspekResponse.fromJson(Map<String, dynamic> json) =>
      MasterDataProspekResponse(
        status: json["status"],
        message: json["message"],
        data: List<MasterData>.from(
            json["Data"].map((x) => MasterData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MasterData {
  MasterData({
    this.id,
    this.nama,
    this.flag,
    this.namaSc,
  });

  int? id;
  String? nama;
  String? flag;
  String? namaSc;

  factory MasterData.fromJson(Map<String, dynamic> json) => MasterData(
        id: json["id"],
        nama: json["nama"],
        flag: json["flag"],
        namaSc: json["namaSc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "flag": flag,
        "namaSc": namaSc,
      };
}
