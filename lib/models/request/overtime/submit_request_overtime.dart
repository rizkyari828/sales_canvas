// To parse this JSON data, do
//
//     final submitOvertimeRequest = submitOvertimeRequestFromJson(jsonString);

import 'dart:convert';

SubmitOvertimeRequest submitOvertimeRequestFromJson(String str) =>
    SubmitOvertimeRequest.fromJson(json.decode(str));

String submitOvertimeRequestToJson(SubmitOvertimeRequest data) =>
    json.encode(data.toJson());

class SubmitOvertimeRequest {
  SubmitOvertimeRequest(
      {this.userId,
      this.name,
      this.sourceId,
      this.token,
      this.latitude,
      this.longitude,
      this.note});

  String? name, token;
  int? sourceId, userId;
  String? latitude, longitude, note;

  factory SubmitOvertimeRequest.fromJson(Map<String, dynamic> json) =>
      SubmitOvertimeRequest(
          userId: json["user_id"] == null ? null : json["user_id"],
          name: json["nama"] == null ? null : json["nama"],
          sourceId: json["sumber_data"] == null ? null : json["sumber_data"],
          token: json["kunci"] == null ? null : json["kunci"],
          latitude: json["lat"] == null ? null : json["lat"],
          longitude: json["long"] == null ? null : json["long"],
          note: json["keterangan"] == null ? null : json["keterangan"]);

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "nama": name == null ? null : name,
        "sumber_data": sourceId == null ? null : sourceId,
        "kunci": token == null ? null : token,
        "lat": latitude == null ? null : latitude,
        "long": longitude == null ? null : longitude,
        "keterangan": note == null ? null : note,
      };
}
