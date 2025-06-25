// To parse this JSON data, do
//
//     final updateApprovalCutiSalesRequest = updateApprovalCutiSalesRequestFromJson(jsonString);

import 'dart:convert';

UpdateApprovalCutiSalesRequest updateApprovalCutiSalesRequestFromJson(String str) =>
    UpdateApprovalCutiSalesRequest.fromJson(json.decode(str));

String updateApprovalCutiSalesRequestToJson(UpdateApprovalCutiSalesRequest data) =>
    json.encode(data.toJson());

class UpdateApprovalCutiSalesRequest {
  UpdateApprovalCutiSalesRequest({
    this.action,
    this.noteApproval,
  });

  String? action;
  String? noteApproval;

  factory UpdateApprovalCutiSalesRequest.fromJson(Map<String, dynamic> json) =>
      UpdateApprovalCutiSalesRequest(
        action: json["action"],
        noteApproval: json["note_approval"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "note_approval": noteApproval,
      };
}
