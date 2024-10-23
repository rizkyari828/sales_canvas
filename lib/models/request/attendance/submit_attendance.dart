import 'dart:convert';

import 'package:get/get.dart';

class AttendanceSubmitRequest {
  AttendanceSubmitRequest({
    required this.latitude,
    required this.longitude,
    this.idUser,
    this.token,
    this.photo,
    this.idToko,
  });

  String latitude;
  String longitude;
  String? idUser;
  String? token;
  MultipartFile? photo;
  String? idToko;

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
        idToko: json["id_toko"] == null ? null : json["id_toko"],
      );

  Map<String, dynamic> toJson() => {
        "lat": latitude,
        "long": longitude,
        "id_user": idUser,
        "token": token,
        "foto": photo,
        "id_toko": idToko == null ? null : idToko,
      };

  FormData toFormData() {
    return FormData({
      "id_user": idUser,
      "lat": latitude,
      "long": longitude,
      "foto": photo,
      "token": token,
      "id_toko": idToko == null ? null : idToko,
    });
  }
}
