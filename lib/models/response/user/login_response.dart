// To parse this JSON data, do
//
//     final LoginRespons = LoginResponsFromJson(jsonString);

import 'dart:convert';

LoginRespons LoginResponsFromJson(String str) =>
    LoginRespons.fromJson(json.decode(str));

String LoginResponsToJson(LoginRespons data) => json.encode(data.toJson());

class LoginRespons {
  String? status;
  String? message;
  bool? error;
  List<DataLogin>? data;

  LoginRespons({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory LoginRespons.fromJson(Map<String, dynamic> json) => LoginRespons(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<DataLogin>.from(
                json["Data"]!.map((x) => DataLogin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "Data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataLogin {
  int? userId;
  String? token;
  String? nama;
  String? idPegawai;
  String? username;
  String? foto;
  int? stsUser;
  String? tipe;
  Menus? menus;

  DataLogin({
    this.userId,
    this.token,
    this.nama,
    this.idPegawai,
    this.username,
    this.foto,
    this.stsUser,
    this.tipe,
    this.menus,
  });

  factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
        userId: json["user_id"],
        token: json["token"],
        nama: json["nama"],
        idPegawai: json["idPegawai"],
        username: json["username"],
        foto: json["foto"],
        stsUser: json["stsUser"],
        tipe: json["tipe"],
        menus: json["menus"] != null
            ? Menus.fromJson(json["menus"])
            : Menus(
                kunjungan: true,
                nonkunjungan: true,
                leads: true,
                prospek: true,
                // agent: true,
                benefit: false,
                lembur: true,
                cuti: true,
                kuisioner: true,
              ),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "token": token,
        "nama": nama,
        "idPegawai": idPegawai,
        "username": username,
        "foto": foto,
        "stsUser": stsUser,
        "tipe": tipe,
        "menus": menus?.toJson(),
      };
}

class Menus {
  bool? kunjungan;
  bool? nonkunjungan;
  bool? leads;
  bool? prospek;
  bool? agent;
  bool? benefit;
  bool? lembur;
  bool? cuti;
  bool? kuisioner;

  Menus({
    this.kunjungan,
    this.nonkunjungan,
    this.leads,
    this.prospek,
    this.agent,
    this.benefit,
    this.lembur,
    this.cuti,
    this.kuisioner,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        kunjungan: json["kunjungan"],
        leads: json["leads"],
        prospek: json["prospek"],
        agent: json["agent"],
        benefit: json["benefit"],
        lembur: json["lembur"],
        cuti: json["cuti"],
        kuisioner: json["kuisioner"],
      );

  Map<String, dynamic> toJson() => {
        "kunjungan": kunjungan,
        "leads": leads,
        "prospek": prospek,
        "agent": agent,
        "benefit": benefit,
        "lembur": lembur,
        "cuti": cuti,
        "kuisioner": kuisioner,
      };
}
