// To parse this JSON data, do
//
//     final submitOvertimeResponse = submitOvertimeResponseFromJson(jsonString);

import 'dart:convert';

SubmitOvertimeResponse submitOvertimeResponseFromJson(String str) =>
    SubmitOvertimeResponse.fromJson(json.decode(str));

String submitOvertimeResponseToJson(SubmitOvertimeResponse data) =>
    json.encode(data.toJson());

class SubmitOvertimeResponse {
  SubmitOvertimeResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  SubmitOvertime? data;

  factory SubmitOvertimeResponse.fromJson(Map<String, dynamic> json) =>
      SubmitOvertimeResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data:
            json["data"] == null ? null : SubmitOvertime.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
      };
}

class SubmitOvertime {
  SubmitOvertime({
    this.id,
    this.code,
    this.dateRequest,
    this.startTime,
    this.endTime,
    this.note,
    this.actualTime,
    this.totalTime,
    this.userClientId,
    this.userClientBranchId,
    this.userCoordinatorId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.noteApproval,
    this.statusLabel,
    this.branchName,
    this.overtimeRoomPhotos,
    this.userTad,
  });

  int? id;
  String? code;
  DateTime? dateRequest;
  DateTime? startTime;
  DateTime? endTime;
  String? note;
  int? actualTime;
  int? totalTime;
  int? userClientId;
  int? userClientBranchId;
  int? userCoordinatorId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? noteApproval;
  String? statusLabel;
  String? branchName;
  List<dynamic>? overtimeRoomPhotos;
  UserTad? userTad;

  factory SubmitOvertime.fromJson(Map<String, dynamic> json) => SubmitOvertime(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        dateRequest: json["date_request"] == null
            ? null
            : DateTime.parse(json["date_request"]),
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime: json["end_time"],
        note: json["note"] == null ? null : json["note"],
        actualTime: json["actual_time"],
        totalTime: json["total_time"],
        userClientId: json["user_client_id"],
        userClientBranchId: json["user_client_branch_id"],
        userCoordinatorId: json["user_coordinator_id"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        noteApproval: json["note_approval"],
        statusLabel: json["status_label"] == null ? null : json["status_label"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
        overtimeRoomPhotos: json["overtime_room_photos"] == null
            ? null
            : List<dynamic>.from(json["overtime_room_photos"].map((x) => x)),
        userTad: UserTad.fromJson(json["user_tad"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "date_request":
            dateRequest == null ? null : dateRequest?.toIso8601String(),
        "start_time": startTime == null ? null : startTime?.toIso8601String(),
        "end_time": endTime,
        "note": note == null ? null : note,
        "actual_time": actualTime,
        "total_time": totalTime,
        "user_client_id": userClientId,
        "user_client_branch_id": userClientBranchId,
        "user_coordinator_id": userCoordinatorId,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "note_approval": noteApproval,
        "status_label": statusLabel == null ? null : statusLabel,
        "branch_name": branchName == null ? null : branchName,
        "overtime_room_photos": overtimeRoomPhotos == null
            ? null
            : List<dynamic>.from(overtimeRoomPhotos!.map((x) => x)),
        "user_tad": userTad?.toJson(),
      };
}

class UserTad {
  UserTad({
    this.id,
    this.userTypeId,
    this.positionId,
    this.name,
    this.simid,
    this.email,
    this.emailVerifiedAt,
    this.currentTeamId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
  });

  int? id;
  int? userTypeId;
  int? positionId;
  String? name;
  String? simid;
  String? email;
  String? emailVerifiedAt;
  String? currentTeamId;
  String? profilePhotoPath;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fcmToken;

  factory UserTad.fromJson(Map<String, dynamic> json) => UserTad(
        id: json["id"],
        userTypeId: json["user_type_id"],
        positionId: json["position_id"],
        name: json["name"],
        simid: json["simid"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        currentTeamId: json["current_team_id"],
        profilePhotoPath: json["profile_photo_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_type_id": userTypeId,
        "position_id": positionId,
        "name": name,
        "simid": simid,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "current_team_id": currentTeamId,
        "profile_photo_path": profilePhotoPath,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "fcm_token": fcmToken,
      };
}
