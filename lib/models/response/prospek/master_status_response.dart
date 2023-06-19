// To parse this JSON data, do
//
//     final masterStatusProspekResponse = masterStatusProspekResponseFromJson(jsonString);

import 'dart:convert';

MasterStatusProspekResponse masterStatusProspekResponseFromJson(String str) =>
    MasterStatusProspekResponse.fromJson(json.decode(str));

String masterStatusProspekResponseToJson(MasterStatusProspekResponse data) =>
    json.encode(data.toJson());

class MasterStatusProspekResponse {
  MasterStatusProspekResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<MasterStatus>? data;

  factory MasterStatusProspekResponse.fromJson(Map<String, dynamic> json) =>
      MasterStatusProspekResponse(
        status: json["status"],
        message: json["message"],
        data: List<MasterStatus>.from(
            json["Data"].map((x) => MasterStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MasterStatus {
  MasterStatus({
    this.id,
    this.namaCat,
  });

  int? id;
  String? namaCat;

  factory MasterStatus.fromJson(Map<String, dynamic> json) => MasterStatus(
        id: json["id"],
        namaCat: json["namaCat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "namaCat": namaCat,
      };
}
