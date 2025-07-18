// To parse this JSON data, do
//
//     final SubmitStatusLeadRequest = SubmitStatusLeadRequestFromJson(jsonString);

import 'dart:convert';

SubmitStatusLeadRequest SubmitStatusLeadRequestFromJson(String str) =>
    SubmitStatusLeadRequest.fromJson(json.decode(str));

String SubmitStatusLeadRequestToJson(SubmitStatusLeadRequest data) =>
    json.encode(data.toJson());

class SubmitStatusLeadRequest {
  SubmitStatusLeadRequest({this.idUser, this.idStatusLead, this.idLead});

  String? idUser;
  String? idStatusLead;
  String? idLead;

  factory SubmitStatusLeadRequest.fromJson(Map<String, dynamic> json) =>
      SubmitStatusLeadRequest(
          idUser: json["user_id"],
          idStatusLead: json["id_status_lead"],
          idLead: json["id_lead"]);

  Map<String, dynamic> toJson() =>
      {'user_id': idUser, 'id_status_lead': idStatusLead, 'id_lead': idLead};
}
