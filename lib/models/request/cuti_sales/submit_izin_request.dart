// To parse this JSON data, do
//
//     final SubmitCutiSalesRequest = SubmitCutiSalesRequestFromJson(jsonString);

import 'dart:convert';

SubmitCutiSalesRequest submitCutiSalesRequestFromJson(String str) =>
    SubmitCutiSalesRequest.fromJson(json.decode(str));

String submitCutiSalesRequestToJson(SubmitCutiSalesRequest data) =>
    json.encode(data.toJson());

class SubmitCutiSalesRequest {
  SubmitCutiSalesRequest({
    this.idUser,
    this.startDate,
    this.endDate,
    this.note,
  });

  String? idUser;
  String? startDate;
  String? endDate;
  String? note;

  factory SubmitCutiSalesRequest.fromJson(Map<String, dynamic> json) =>
      SubmitCutiSalesRequest(
        idUser: json["user_id"],
        startDate: json["tgl_awal"],
        endDate: json["tgl_akhir"],
        note: json["keperluan"],
      );

  Map<String, dynamic> toJson() => {
        'user_id': idUser,
        "tgl_awal": startDate,
        "tgl_akhir": endDate,
        "keperluan": note,
      };
}
