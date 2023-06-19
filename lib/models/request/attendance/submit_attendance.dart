import 'dart:convert';

import 'package:get/get.dart';

class AttendanceSubmitRequest {
  AttendanceSubmitRequest(
      {required this.latitude,
      required this.longitude,
      this.idUser,
      this.token,
      this.photo});

  String latitude;
  String longitude;
  String? idUser;
  String? token;
  MultipartFile? photo;

  factory AttendanceSubmitRequest.fromRawJson(String str) =>
      AttendanceSubmitRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceSubmitRequest.fromJson(Map<String, dynamic> json) =>
      AttendanceSubmitRequest(
        latitude: json["lat"],
        longitude: json["long"],
        idUser: json["idUser"],
        token: json["token"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "lat": latitude,
        "long": longitude,
        "id_user": idUser,
        "token": token,
        "foto": photo,
      };

  FormData toFormData() {
    return FormData({
      "id_user": idUser,
      "lat": latitude,
      "long": longitude,
      "foto": photo,
      "token": token,
    });
  }
}
