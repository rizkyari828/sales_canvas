// To parse this JSON data, do
//
//     final SubmitStatusLeadRequest = SubmitStatusLeadRequestFromJson(jsonString);

import 'dart:convert';

SubmitStatusLeadRequest SubmitStatusLeadRequestFromJson(String str) =>
    SubmitStatusLeadRequest.fromJson(json.decode(str));

String SubmitStatusLeadRequestToJson(SubmitStatusLeadRequest data) =>
    json.encode(data.toJson());

class SubmitStatusLeadRequest {
  SubmitStatusLeadRequest({this.idStatusLead, this.idLead});

  int? idStatusLead;
  int? idLead;

  factory SubmitStatusLeadRequest.fromJson(Map<String, dynamic> json) =>
      SubmitStatusLeadRequest(
          idStatusLead: json["status_leads"], idLead: json["id_leads"]);

  Map<String, dynamic> toJson() =>
      {'status_leads': idStatusLead, 'id_leads': idLead};
}
