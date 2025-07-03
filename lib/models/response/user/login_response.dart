// To parse this JSON data, do
//
//     final loginRespons = loginResponsFromJson(jsonString);

import 'dart:convert';

LoginRespons loginResponsFromJson(String str) =>
    LoginRespons.fromJson(json.decode(str));

String loginResponsToJson(LoginRespons data) => json.encode(data.toJson());

class LoginRespons {
  LoginRespons({this.status, this.message, this.data, this.error});

  String? status;
  String? message;
  bool? error;
  List<DataLogin>? data;

  factory LoginRespons.fromJson(Map<String, dynamic> json) => LoginRespons(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: List<DataLogin>.from(
            json["Data"].map((x) => DataLogin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataLogin {
  DataLogin({
    this.userId,
    this.token,
    this.nama,
    this.idPegawai,
    this.username,
    this.foto,
    this.groupUser,
    this.tipe,
  });

  int? userId;
  String? token;
  String? nama;
  String? idPegawai;
  String? username;
  String? foto;
  int? groupUser;
  String? tipe;

  factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
        userId: json["user_id"],
        token: json["token"],
        nama: json["nama"],
        idPegawai: json["idPegawai"],
        username: json["username"],
        foto: json["foto"],
        groupUser: json["stsUser"],
        tipe: json["tipe"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "token": token,
        "nama": nama,
        "idPegawai": idPegawai,
        "foto": foto,
        "stsUser": groupUser,
        "tipe": tipe,
      };
}
