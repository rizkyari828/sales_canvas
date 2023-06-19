// To parse this JSON data, do
//
//     final updateApprovalOvertimeRequest = updateApprovalOvertimeRequestFromJson(jsonString);

import 'dart:convert';

class UpdateApprovalOvertimeRequest {
  UpdateApprovalOvertimeRequest(
      {this.noTrans, this.status, this.action, this.kunci, this.note, this.type});

  String? noTrans, kunci, note;
  int? action, status, type;

  factory UpdateApprovalOvertimeRequest.fromRawJson(String str) =>
      UpdateApprovalOvertimeRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateApprovalOvertimeRequest.fromJson(Map<String, dynamic> json) =>
      UpdateApprovalOvertimeRequest(
        action: json["action"],
        noTrans: json["noTrans"],
        status: json["status"],
        kunci: json["kunci"],
        note: json["note"],
        type: json["tipe"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "noTrans": noTrans,
        "status": status,
        "kunci": kunci,
        "note": note,
        "tipe": type
      };
}
