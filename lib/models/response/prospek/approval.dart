// To parse this JSON data, do
//
//     final updateApprovalOvertimeRespons = updateApprovalOvertimeResponsFromJson(jsonString);

import 'dart:convert';

UpdateApprovalOvertimeRespons updateApprovalOvertimeResponsFromJson(
        String str) =>
    UpdateApprovalOvertimeRespons.fromJson(json.decode(str));

String updateApprovalOvertimeResponsToJson(
        UpdateApprovalOvertimeRespons data) =>
    json.encode(data.toJson());

class UpdateApprovalOvertimeRespons {
  UpdateApprovalOvertimeRespons({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory UpdateApprovalOvertimeRespons.fromJson(Map<String, dynamic> json) =>
      UpdateApprovalOvertimeRespons(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
