import 'dart:convert';

class AttendanceValidateRequest {
  AttendanceValidateRequest({
    required this.latitude,
    required this.longitude,
    this.id,
    this.token,
    this.idToko,
  });

  String latitude;
  String longitude;
  String? id;
  String? token;
  String? idToko;

  factory AttendanceValidateRequest.fromRawJson(String str) =>
      AttendanceValidateRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceValidateRequest.fromJson(Map<String, dynamic> json) =>
      AttendanceValidateRequest(
        latitude: json["lat"],
        longitude: json["long"],
        id: json["id_user"],
        token: json["token"],
        idToko: json["idToko"] == null ? null : json["idToko"],
      );

  Map<String, dynamic> toJson() => {
        "lat": latitude,
        "long": longitude,
        "id_user": id,
        "token": token,
        "idToko": idToko == null ? null : idToko,
      };
}
