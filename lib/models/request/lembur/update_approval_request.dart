// To parse this JSON data, do
//
//     final updateApprovalLemburRequest = updateApprovalLemburRequestFromJson(jsonString);

import 'dart:convert';

UpdateApprovalLemburRequest updateApprovalLemburRequestFromJson(String str) =>
    UpdateApprovalLemburRequest.fromJson(json.decode(str));

String updateApprovalLemburRequestToJson(UpdateApprovalLemburRequest data) =>
    json.encode(data.toJson());

class UpdateApprovalLemburRequest {
  UpdateApprovalLemburRequest({
    this.id,
    this.action,
    this.noteApproval,
  });

  String? id;
  String? action;
  String? noteApproval;

  factory UpdateApprovalLemburRequest.fromJson(Map<String, dynamic> json) =>
      UpdateApprovalLemburRequest(
        id: json["id_lembur"],
        action: json["sts"],
        noteApproval: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id_lembur": id,
        "sts": action,
        "note": noteApproval,
      };
}
