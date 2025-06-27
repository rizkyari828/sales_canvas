// To parse this JSON data, do
//
//     final updateApprovalCutiSalesRequest = updateApprovalCutiSalesRequestFromJson(jsonString);

import 'dart:convert';

UpdateApprovalCutiSalesRequest updateApprovalCutiSalesRequestFromJson(
        String str) =>
    UpdateApprovalCutiSalesRequest.fromJson(json.decode(str));

String updateApprovalCutiSalesRequestToJson(
        UpdateApprovalCutiSalesRequest data) =>
    json.encode(data.toJson());

class UpdateApprovalCutiSalesRequest {
  UpdateApprovalCutiSalesRequest({
    this.id,
    this.action,
    this.noteApproval,
  });

  String? id;
  String? action;
  String? noteApproval;

  factory UpdateApprovalCutiSalesRequest.fromJson(Map<String, dynamic> json) =>
      UpdateApprovalCutiSalesRequest(
        id: json["id_cuti"],
        action: json["sts"],
        noteApproval: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id_cuti": id,
        "sts": action,
        "note": noteApproval,
      };
}
