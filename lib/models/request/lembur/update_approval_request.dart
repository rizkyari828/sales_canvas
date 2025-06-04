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
    this.action,
    this.noteApproval,
  });

  String? action;
  String? noteApproval;

  factory UpdateApprovalLemburRequest.fromJson(Map<String, dynamic> json) =>
      UpdateApprovalLemburRequest(
        action: json["action"],
        noteApproval: json["note_approval"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "note_approval": noteApproval,
      };
}
