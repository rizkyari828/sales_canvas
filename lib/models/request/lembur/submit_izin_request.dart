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

  factory SubmitLemburRequest.fromJson(Map<String, dynamic> json) =>
      SubmitLemburRequest(
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
