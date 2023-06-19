// To parse this JSON data, do
//
//     final SubmitInputRequest = SubmitInputRequestFromJson(jsonString);

import 'dart:convert';

SubmitInputRequest submitInputRequestFromJson(String str) =>
    SubmitInputRequest.fromJson(json.decode(str));

String submitInputRequestToJson(SubmitInputRequest data) =>
    json.encode(data.toJson());

class SubmitInputRequest {
  SubmitInputRequest({
    this.idUser,
    this.token,
    this.nipAdira,
    this.totalBahanCRM,
    this.jumlahFuWalk,
    this.jumlahFuCRM,
    this.jumahBerminat,
    this.jumlahPikirPikir,
    this.jumlahBelumBerminat,
    this.jumlahTidakBisaDihubungi,
    this.jumlah3n,
    this.jumlahOrder,
    this.jumlahMCY,
    this.jumlahCAR,
    this.totalMCYCAR,
    this.totalMCY,
    this.totalCAR,
  });

  String? idUser;
  String? token;
  String? nipAdira;
  int? totalBahanCRM;
  int? jumlahFuWalk;
  int? jumlahFuCRM;
  int? jumahBerminat;
  int? jumlahPikirPikir;
  int? jumlahBelumBerminat;
  int? jumlahTidakBisaDihubungi;
  int? jumlah3n;
  int? jumlahOrder;
  int? jumlahMCY;
  int? totalMCYCAR;
  int? jumlahCAR;
  int? totalMCY;
  int? totalCAR;

  factory SubmitInputRequest.fromJson(Map<String, dynamic> json) =>
      SubmitInputRequest(
        idUser: json["user_id"],
        token: json["token"],
        nipAdira: json["nip_adira"],
        totalBahanCRM: json["total_bahan_crm_awal"],
        jumlahFuWalk: json["jml_follow_walkin"],
        jumlahFuCRM: json["jml_follow_crm"],
        jumahBerminat: json["jml_konsumen_minat"],
        jumlahPikirPikir: json["jml_konsumen_pikir"],
        jumlahBelumBerminat: json["jml_konsumen_ga_minta"],
        jumlahTidakBisaDihubungi: json["jml_konsumen_not_call"],
        jumlah3n: json["jml_agen_n"],
        jumlahOrder: json["jml_order"],
        jumlahMCY: json["jml_booking_mcy"],
        jumlahCAR: json["jml_booking_car"],
        totalMCYCAR: json["total_mcy_car"],
        totalMCY: json["total_mcy_satu"],
        totalCAR: json["total_car_satu"],
      );

  Map<String, dynamic> toJson() => {
        'user_id': idUser,
        "token": token,
        "nip_adira": nipAdira,
        "total_bahan_crm_awal": totalBahanCRM,
        "jml_follow_walkin": jumlahFuWalk,
        "jml_follow_crm": jumlahFuCRM,
        "jml_konsumen_minat": jumahBerminat,
        "jml_konsumen_pikir": jumlahPikirPikir,
        "jml_konsumen_ga_minta": jumlahBelumBerminat,
        "jml_konsumen_not_call": jumlahTidakBisaDihubungi,
        "jml_agen_n": jumlah3n,
        "jml_order": jumlahOrder,
        "jml_booking_mcy": jumlahMCY,
        "jml_booking_car": jumlahCAR,
        "total_mcy_car": totalMCYCAR,
        "total_mcy_satu": totalMCY,
        "total_car_satu": totalCAR,
      };
}
