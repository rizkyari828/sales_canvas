// To parse this JSON data, do
//
//     final showCutiResponse = showCutiResponseFromJson(jsonString);

import 'dart:convert';

ShowCutiResponse showCutiResponseFromJson(String str) =>
    ShowCutiResponse.fromJson(json.decode(str));

String showCutiResponseToJson(ShowCutiResponse data) =>
    json.encode(data.toJson());

class ShowCutiResponse {
  ShowCutiResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  DataCuti? data;

  factory ShowCutiResponse.fromJson(Map<String, dynamic> json) =>
      ShowCutiResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : DataCuti.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
      };
}

class DataCuti {
  DataCuti({
    this.id,
    this.leaveTypeId,
    this.code,
    this.documents,
    this.dateRequest,
    this.dateStart,
    this.dateEnd,
    this.note,
    this.noteApproval,
    this.status,
    this.statusLabel,
    this.branchName,
    this.leaveTypeName,
    this.userTad,
    this.branch,
  });

  int? id;
  int? leaveTypeId;
  String? code;
  String? documents;
  DateTime? dateRequest;
  DateTime? dateStart;
  DateTime? dateEnd;
  String? note;
  String? noteApproval;
  String? status;
  String? statusLabel;
  String? branchName;
  String? leaveTypeName;
  UserTad? userTad;
  Branch? branch;

  factory DataCuti.fromJson(Map<String, dynamic> json) => DataCuti(
        id: json["id"] == null ? null : json["id"],
        leaveTypeId:
            json["leave_type_id"] == null ? null : json["leave_type_id"],
        code: json["code"] == null ? null : json["code"],
        documents: json["documents"],
        dateRequest: json["date_request"] == null
            ? null
            : DateTime.parse(json["date_request"]),
        dateStart: json["date_start"] == null
            ? null
            : DateTime.parse(json["date_start"]),
        dateEnd:
            json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        note: json["note"] == null ? null : json["note"],
        noteApproval: json["note_approval"],
        status: json["status"] == null ? null : json["status"],
        statusLabel: json["status_label"] == null ? null : json["status_label"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
        leaveTypeName:
            json["leave_type_name"] == null ? null : json["leave_type_name"],
        userTad: UserTad.fromJson(json["user_tad"]),
        branch: Branch.fromJson(json["branch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "leave_type_id": leaveTypeId == null ? null : leaveTypeId,
        "code": code == null ? null : code,
        "documents": documents,
        "date_request":
            dateRequest == null ? null : dateRequest?.toIso8601String(),
        "date_start": dateStart == null ? null : dateStart?.toIso8601String(),
        "date_end": dateEnd == null ? null : dateEnd?.toIso8601String(),
        "note": note == null ? null : note,
        "note_approval": noteApproval,
        "status": status == null ? null : status,
        "status_label": statusLabel == null ? null : statusLabel,
        "branch_name": branchName == null ? null : branchName,
        "leave_type_name": leaveTypeName == null ? null : leaveTypeName,
        "user_tad": userTad?.toJson(),
        "branch": branch?.toJson(),
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

class Branch {
    Branch({
        this.id,
        this.companyId,
        this.name,
        this.longitude,
        this.latitude,
        this.radius,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.location,
        this.building,
        this.levelApprovalCnc,
        this.levelApprovalOvertime,
        this.levelApprovalLeave,
        this.code,
        this.conditionCnc,
        this.conditionOvertime,
        this.conditionLeave,
        this.timezone,
        this.companyName,
        this.timeZoneName,
        this.timeZoneCode,
        this.company,
    });

    int? id;
    int? companyId;
    String? name;
    double? longitude;
    double? latitude;
    int? radius;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    String? location;
    String? building;
    String? levelApprovalCnc;
    String? levelApprovalOvertime;
    String? levelApprovalLeave;
    String? code;
    String? conditionCnc;
    String? conditionOvertime;
    String? conditionLeave;
    String? timezone;
    String? companyName;
    String? timeZoneName;
    String? timeZoneCode;
    Company? company;

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        companyId: json["company_id"],
        name: json["name"],
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        radius: json["radius"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        location: json["location"],
        building: json["building"],
        levelApprovalCnc: json["level_approval_cnc"],
        levelApprovalOvertime: json["level_approval_overtime"],
        levelApprovalLeave: json["level_approval_leave"],
        code: json["code"],
        conditionCnc: json["condition_cnc"],
        conditionOvertime: json["condition_overtime"],
        conditionLeave: json["condition_leave"],
        timezone: json["timezone"],
        companyName: json["company_name"],
        timeZoneName: json["time_zone_name"],
        timeZoneCode: json["time_zone_code"],
        company: Company.fromJson(json["company"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "name": name,
        "longitude": longitude,
        "latitude": latitude,
        "radius": radius,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "location": location,
        "building": building,
        "level_approval_cnc": levelApprovalCnc,
        "level_approval_overtime": levelApprovalOvertime,
        "level_approval_leave": levelApprovalLeave,
        "code": code,
        "condition_cnc": conditionCnc,
        "condition_overtime": conditionOvertime,
        "condition_leave": conditionLeave,
        "timezone": timezone,
        "company_name": companyName,
        "time_zone_name": timeZoneName,
        "time_zone_code": timeZoneCode,
        "company": company?.toJson(),
    };
}

class Company {
    Company({
        this.id,
        this.code,
        this.name,
        this.email,
        this.contact,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    int? id;
    String? code;
    String? name;
    String? email;
    String? contact;
    String? address;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        email: json["email"],
        contact: json["contact"],
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "email": email,
        "contact": contact,
        "address": address,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}