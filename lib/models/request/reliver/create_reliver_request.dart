// To parse this JSON data, do
//
//     final createReliverResponse = createReliverResponseFromJson(jsonString);

import 'dart:convert';

CreateReliverRequest createReliverResponseFromJson(String str) =>
    CreateReliverRequest.fromJson(json.decode(str));

String createReliverResponseToJson(CreateReliverRequest data) =>
    json.encode(data.toJson());

class CreateReliverRequest {
  CreateReliverRequest({
    this.branchId,
    this.dateNeeded,
    this.dateEndNeeded,
    this.needEmployee,
    this.note,
    this.dateStartWorkEmployee,
  });

  int? branchId;
  String? dateNeeded;
  String? dateEndNeeded;
  int? needEmployee;
  String? note;
  String? dateStartWorkEmployee;

  factory CreateReliverRequest.fromJson(Map<String, dynamic> json) =>
      CreateReliverRequest(
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        dateNeeded: json["date_needed"] == null ? null : json["date_needed"],
        dateEndNeeded:
            json["date_end_needed"] == null ? null : json["date_end_needed"],
        needEmployee:
            json["need_employee"] == null ? null : json["need_employee"],
        note: json["note"] == null ? null : json["note"],
        dateStartWorkEmployee: json["date_start_work_employee"] == null
            ? null
            : json["date_start_work_employee"],
      );

  Map<String, dynamic> toJson() => {
        "branch_id": branchId == null ? null : branchId,
        "date_needed": dateNeeded == null ? null : dateNeeded,
        "date_end_needed": dateEndNeeded == null ? null : dateEndNeeded,
        "need_employee": needEmployee == null ? null : needEmployee,
        "note": note == null ? null : note,
        "date_start_work_employee":
            dateStartWorkEmployee == null ? null : dateStartWorkEmployee,
      };
}
