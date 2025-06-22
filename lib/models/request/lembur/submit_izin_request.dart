// To parse this JSON data, do
//
//     final SubmitLemburRequest = SubmitLemburRequestFromJson(jsonString);

import 'dart:convert';

SubmitLemburRequest submitLemburRequestFromJson(String str) =>
    SubmitLemburRequest.fromJson(json.decode(str));

String submitLemburRequestToJson(SubmitLemburRequest data) =>
    json.encode(data.toJson());

class SubmitLemburRequest {
  SubmitLemburRequest({
    this.idUser,
    this.date,
    this.startTime,
    this.endTime,
    this.note,
  });

  String? idUser;
  String? date;
  String? startTime;
  String? endTime;
  String? note;

  factory SubmitLemburRequest.fromJson(Map<String, dynamic> json) =>
      SubmitLemburRequest(
        idUser: json["user_id"],
        date: json["tanggal_lembur"],
        startTime: json["jam_in"],
        endTime: json["jam_out"],
        note: json["keperluan"],
      );

  Map<String, dynamic> toJson() => {
        'user_id': idUser,
        "tanggal_lembur": date,
        "jam_in": startTime,
        "jam_out": endTime,
        "keperluan": note,
      };
}
