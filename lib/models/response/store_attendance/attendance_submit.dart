// To parse this JSON data, do
//
//     final attendanceSubmitResponse = attendanceSubmitResponseFromJson(jsonString);

import 'dart:convert';

AttendanceSubmitResponse attendanceSubmitResponseFromJson(String str) =>
    AttendanceSubmitResponse.fromJson(json.decode(str));

String attendanceSubmitResponseToJson(AttendanceSubmitResponse data) =>
    json.encode(data.toJson());

class AttendanceSubmitResponse {
  AttendanceSubmitResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Data? data;

  factory AttendanceSubmitResponse.fromJson(Map<String, dynamic> json) =>
      AttendanceSubmitResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.scheduleId,
    this.usersId,
    this.attendenceStatusId,
    this.checkIn,
    this.checkOut,
    this.dateAttendence,
    this.longitudeCheckIn,
    this.longitudeCheckOut,
    this.latitudeCheckIn,
    this.latitudeCheckOut,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.attendenceStatus,
  });

  int? id;
  int? scheduleId;
  int? usersId;
  int? attendenceStatusId;
  String? checkIn;
  String? checkOut;
  String? dateAttendence;
  double? longitudeCheckIn;
  double? longitudeCheckOut;
  double? latitudeCheckIn;
  double? latitudeCheckOut;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  AttendenceStatus? attendenceStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        scheduleId: json["schedule_id"] == null ? null : json["schedule_id"],
        usersId: json["users_id"] == null ? null : json["users_id"],
        attendenceStatusId: json["attendence_status_id"] == null
            ? null
            : json["attendence_status_id"],
        checkIn: json["check_in"] == null ? null : json["check_in"],
        checkOut: json["check_out"],
        dateAttendence:
            json["date_attendence"] == null ? null : json["date_attendence"],
        longitudeCheckIn: json["longitude_check_in"] == null
            ? null
            : json["longitude_check_in"].toDouble(),
        longitudeCheckOut: json["longitude_check_out"],
        latitudeCheckIn: json["latitude_check_in"] == null
            ? null
            : json["latitude_check_in"].toDouble(),
        latitudeCheckOut: json["latitude_check_out"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        deletedAt: json["deleted_at"],
        attendenceStatus: json["attendence_status"] == null
            ? null
            : AttendenceStatus.fromJson(json["attendence_status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "schedule_id": scheduleId == null ? null : scheduleId,
        "users_id": usersId == null ? null : usersId,
        "attendence_status_id":
            attendenceStatusId == null ? null : attendenceStatusId,
        "check_in": checkIn == null ? null : checkIn,
        "check_out": checkOut,
        "date_attendence": dateAttendence == null ? null : dateAttendence,
        "longitude_check_in":
            longitudeCheckIn == null ? null : longitudeCheckIn,
        "longitude_check_out": longitudeCheckOut,
        "latitude_check_in": latitudeCheckIn == null ? null : latitudeCheckIn,
        "latitude_check_out": latitudeCheckOut,
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "deleted_at": deletedAt,
        "attendence_status":
            attendenceStatus == null ? null : attendenceStatus?.toJson(),
      };
}

class AttendenceStatus {
  AttendenceStatus({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory AttendenceStatus.fromJson(Map<String, dynamic> json) =>
      AttendenceStatus(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "deleted_at": deletedAt == null ? null : createdAt,
      };
}
