// To parse this JSON data, do
//
//     final SubmitLeadRequest = SubmitLeadRequestFromJson(jsonString);

import 'dart:convert';

import 'package:sales/models/request/attendance/attendance_wrapper.dart';

SubmitLeadRequest SubmitLeadRequestFromJson(String str) =>
    SubmitLeadRequest.fromJson(json.decode(str));

String SubmitLeadRequestToJson(SubmitLeadRequest data) =>
    json.encode(data.toJson());

class SubmitLeadRequest {
  SubmitLeadRequest({
    this.idUser,
    this.date,
    this.leadSource,
    this.email,
    this.name,
    this.noHp,
    this.latitude,
    this.longitude,
    this.leadCategory,
    this.minatProduct,
    this.leadStatus,
    this.note,
    this.photos,
  });

  String? idUser;
  String? date;
  String? leadSource;
  String? email;
  String? name;
  String? noHp;
  String? latitude;
  String? longitude;
  String? leadCategory;
  String? minatProduct;
  String? leadStatus;
  String? note;
  final List<PhotoAttachment>? photos;

  factory SubmitLeadRequest.fromJson(Map<String, dynamic> json) =>
      SubmitLeadRequest(
        idUser: json["id_user"],
        date: json["date"],
        leadSource: json["lead_source"],
        email: json["email"],
        name: json["name"],
        noHp: json["ho_hp"],
        latitude: json["lat"],
        longitude: json["long"],
        leadCategory: json["lead_category"],
        minatProduct: json["minat_product"],
        leadStatus: json["lead_status"],
        note: json["note"],
        photos: (json['foto'] as List? ?? [])
            .map((e) => PhotoAttachment.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id_user': idUser,
        'date': date,
        'lead_source': leadSource,
        'email': email,
        'name': name,
        'ho_hp': noHp,
        'lat': latitude,
        'long': longitude,
        'lead_category': leadCategory,
        'minat_product': minatProduct,
        'lead_status': leadStatus,
        'note': note,
        'foto': photos?.map((e) => e.toJson()).toList(),
      };
}
