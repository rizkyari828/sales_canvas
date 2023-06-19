// To parse this JSON data, do
//
//     final SubmitIzinRequest = SubmitIzinRequestFromJson(jsonString);

import 'dart:convert';

SubmitIzinRequest submitIzinRequestFromJson(String str) =>
    SubmitIzinRequest.fromJson(json.decode(str));

String submitIzinRequestToJson(SubmitIzinRequest data) =>
    json.encode(data.toJson());

class SubmitIzinRequest {
  SubmitIzinRequest({
    this.idUser,
    this.leaveTypeId,
    this.dateStart,
    this.dateEnd,
    this.note,
    this.token,
  });

  String? idUser;
  String? leaveTypeId;
  String? dateStart;
  String? dateEnd;
  String? note;
  String? token;

  factory SubmitIzinRequest.fromJson(Map<String, dynamic> json) =>
      SubmitIzinRequest(
        idUser: json["id_user"],
        leaveTypeId: json["type_ijin"],
        dateStart: json["date_in"],
        dateEnd: json["date_out"],
        note: json["keterangan"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        'id_user': idUser,
        "type_ijin": leaveTypeId,
        "date_in": dateStart,
        "date_out": dateEnd,
        "keterangan": note,
        "token": token,
      };
}
