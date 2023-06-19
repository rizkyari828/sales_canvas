// To parse this JSON data, do
//
//     final masterIdProspekResponse = masterIdProspekResponseFromJson(jsonString);

import 'dart:convert';

MasterIdProspekResponse masterIdProspekResponseFromJson(String str) =>
    MasterIdProspekResponse.fromJson(json.decode(str));

String masterIdProspekResponseToJson(MasterIdProspekResponse data) =>
    json.encode(data.toJson());

class MasterIdProspekResponse {
  MasterIdProspekResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<MasterId>? data;

  factory MasterIdProspekResponse.fromJson(Map<String, dynamic> json) =>
      MasterIdProspekResponse(
        status: json["status"],
        message: json["message"],
        data:
            List<MasterId>.from(json["Data"].map((x) => MasterId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MasterId {
  MasterId({
    this.id,
    this.namaSc,
  });

  int? id;
  String? namaSc;

  factory MasterId.fromJson(Map<String, dynamic> json) => MasterId(
        id: json["id"],
        namaSc: json["namaSc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "namaSc": namaSc,
      };
}
