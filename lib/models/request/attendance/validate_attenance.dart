import 'dart:convert';

class AttendanceValidateRequest {
  AttendanceValidateRequest({
    required this.latitude,
    required this.longitude,
    this.id,
    this.token,
  });

  String latitude;
  String longitude;
  String? id;
  String? token;

  factory AttendanceValidateRequest.fromRawJson(String str) =>
      AttendanceValidateRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceValidateRequest.fromJson(Map<String, dynamic> json) =>
      AttendanceValidateRequest(
        latitude: json["lat"],
        longitude: json["long"],
        id: json["id_user"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "lat": latitude,
        "long": longitude,
        "id_user": id,
        "token": token,
      };
}
