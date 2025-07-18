// To parse this JSON data, do
//
//     final leadResponse = leadResponseFromJson(jsonString);

import 'dart:convert';

LeadResponse leadResponseFromJson(String str) =>
    LeadResponse.fromJson(json.decode(str));

String leadResponseToJson(LeadResponse data) => json.encode(data.toJson());

class LeadResponse {
  String? status;
  String? message;
  bool? error;
  List<DataLead>? data;

  LeadResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory LeadResponse.fromJson(Map<String, dynamic> json) => LeadResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<DataLead>.from(
                json["Data"]!.map((x) => DataLead.fromJson(x))),
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

class DataLead {
  String? sumberLeadsValue;
  int? sumberLeadsId;
  dynamic sumberLeads2;
  String? nama;
  String? email;
  String? telphone;
  String? alamat;
  String? productMinat;
  String? catatan;
  String? statusLead;
  String? idLead;
  List<Foto>? foto;

  DataLead({
    this.sumberLeadsValue,
    this.sumberLeadsId,
    this.sumberLeads2,
    this.nama,
    this.email,
    this.telphone,
    this.alamat,
    this.productMinat,
    this.catatan,
    this.statusLead,
    this.idLead,
    this.foto,
  });

  factory DataLead.fromJson(Map<String, dynamic> json) => DataLead(
        sumberLeadsValue: json["sumber_leads_value"],
        sumberLeadsId: json["sumber_leads_id"],
        sumberLeads2: json["sumber_leads2"],
        nama: json["nama"],
        email: json["email"],
        telphone: json["telphone"],
        alamat: json["alamat"],
        productMinat: json["product_minat"],
        catatan: json["catatan"],
        statusLead: json["status_lead"],
        idLead: json["id_lead"],
        foto: json["Foto"] == null
            ? []
            : List<Foto>.from(json["Foto"]!.map((x) => Foto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sumber_leads_value": sumberLeadsValue,
        "sumber_leads_id": sumberLeadsId,
        "sumber_leads2": sumberLeads2,
        "nama": nama,
        "email": email,
        "telphone": telphone,
        "alamat": alamat,
        "product_minat": productMinat,
        "catatan": catatan,
        "status_lead": statusLead,
        "id_lead": idLead,
        "Foto": foto == null
            ? []
            : List<dynamic>.from(foto!.map((x) => x.toJson())),
      };
}

class Foto {
  String? img;

  Foto({
    this.img,
  });

  factory Foto.fromJson(Map<String, dynamic> json) => Foto(
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
      };
}
