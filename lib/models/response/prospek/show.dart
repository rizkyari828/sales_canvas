// To parse this JSON data, do
//
//     final showProspekResponse = showProspekResponseFromJson(jsonString);

import 'dart:convert';

ShowProspekResponse showProspekResponseFromJson(String str) =>
    ShowProspekResponse.fromJson(json.decode(str));

String showProspekResponseToJson(ShowProspekResponse data) =>
    json.encode(data.toJson());

class ShowProspekResponse {
  ShowProspekResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<ProspekDetail>? data;

  factory ShowProspekResponse.fromJson(Map<String, dynamic> json) =>
      ShowProspekResponse(
        status: json["status"],
        message: json["message"],
        data: List<ProspekDetail>.from(
            json["Data"].map((x) => ProspekDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProspekDetail {
  ProspekDetail(
      {this.id,
      this.noTrans,
      this.nama,
      this.cdate,
      this.namaLengkap,
      this.type,
      this.nobpkp,
      this.merek,
      this.phone,
      this.userid,
      this.status,
      this.namaCat,
      this.source,
      this.reason,
      this.keterangan,
      this.vehicleType});

  int? id;
  String? noTrans;
  String? nama;
  DateTime? cdate;
  String? namaLengkap;
  String? type;
  String? nobpkp;
  String? merek;
  String? phone;
  String? userid;
  String? status;
  String? namaCat;
  String? source;
  String? reason;
  String? keterangan;
  String? vehicleType;

  factory ProspekDetail.fromJson(Map<String, dynamic> json) => ProspekDetail(
        id: json["id"],
        noTrans: json["no_trans"],
        nama: json["nama"],
        cdate: DateTime.parse(json["cdate"]),
        namaLengkap: json["nama_lengkap"],
        type: json["type"],
        nobpkp: json["nobpkp"],
        merek: json["merek"],
        phone: json["phone"],
        userid: json["userid"],
        status: json["status"],
        namaCat: json["namaCat"],
        source: json["SCO"],
        reason: json["reason"],
        keterangan: json["keterangan"],
        vehicleType: json["tipe"] == '1'
            ? 'Motor'
            : json["tipe"] == '2'
                ? 'Mobil'
                : '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no_trans": noTrans,
        "nama": nama,
        "cdate": cdate?.toIso8601String(),
        "nama_lengkap": namaLengkap,
        "type": type,
        "nobpkp": nobpkp,
        "merek": merek,
        "phone": phone,
        "userid": userid,
        "status": status,
        "namaCat": namaCat,
        "SCO": source,
        "reason": reason,
        "keterangan": keterangan,
        "tipe": vehicleType == '1'
            ? 'Motor'
            : vehicleType == '2'
                ? 'Mobil'
                : '',
      };
}
