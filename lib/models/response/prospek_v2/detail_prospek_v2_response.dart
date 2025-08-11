// To parse this JSON data, do
//
//     final ShowProspekV2Response = ShowProspekV2ResponseFromJson(jsonString);

import 'dart:convert';

ShowProspekV2Response showProspekV2ResponseFromJson(String str) =>
    ShowProspekV2Response.fromJson(json.decode(str));

String showProspekV2ResponseToJson(ShowProspekV2Response data) =>
    json.encode(data.toJson());

class ShowProspekV2Response {
  ShowProspekV2Response({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  String? status;
  String? message;
  bool? error;
  List<ProspekDetailV2>? data;

  factory ShowProspekV2Response.fromJson(Map<String, dynamic> json) =>
      ShowProspekV2Response(
        status: json["status"],
        message: json["message"],
        error: json['error'],
        data: List<ProspekDetailV2>.from(
            json["Data"].map((x) => ProspekDetailV2.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        'error': error,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProspekDetailV2 {
  int? id;
  int? idLead;
  String? prospectName;
  String? productName;
  int? totalTransaction;
  dynamic dateCalled;
  dynamic dateFu;
  String? noteCommunication;
  String? reasonNotOrder;
  String? dateLastUpdate;
  String? sourceOrderValue;
  String? mediaCommunicationValue;
  String? statusProspectValue;
  int? idStatusProspect;
  int? idMediaCommunication;
  int? idStatusOrder;
  int? idProduct;
  String? gender;
  String? age;

  ProspekDetailV2(
      {this.id,
      this.idLead,
      this.prospectName,
      this.productName,
      this.totalTransaction,
      this.dateCalled,
      this.dateFu,
      this.noteCommunication,
      this.reasonNotOrder,
      this.dateLastUpdate,
      this.sourceOrderValue,
      this.mediaCommunicationValue,
      this.statusProspectValue,
      this.idStatusProspect,
      this.idMediaCommunication,
      this.idStatusOrder,
      this.idProduct,
      this.age,
      this.gender});

  factory ProspekDetailV2.fromJson(Map<String, dynamic> json) {
    print(json); // Untuk debug
    return ProspekDetailV2(
      id: json["id_prospek"],
      idLead: json["id_leads"], // Akan null jika tidak ada di response
      prospectName: json["nama"],
      productName: json["produk_value"],
      totalTransaction: json["estimasi_pinjaman"],
      dateCalled: json["cdate"] == null ? null : DateTime.parse(json["cdate"]),
      dateFu:
          json["date_next"] == null ? null : DateTime.parse(json["date_next"]),
      noteCommunication: json["catatan"],
      reasonNotOrder: json["alasan"],
      dateLastUpdate: json["date_last_update"],
      sourceOrderValue: json["status_order_value"],
      mediaCommunicationValue: json["media_value"],
      statusProspectValue: json["status_prospek_value"] ??
          json["status_prospek_new"], // <-- cek dua key
      idStatusProspect: json["status_prospek"],
      idMediaCommunication: json["media"],
      idStatusOrder: json["status_order"],
      idProduct: json["produk"],
      gender: json["jenis_kelamin"],
      age: json["umur"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_prospek": id,
        'id_leads': idLead,
        "nama": prospectName,
        "produk_value": productName,
        "estimasi_pinjaman": totalTransaction,
        "cdate":
            "${dateCalled!.year.toString().padLeft(4, '0')}-${dateCalled!.month.toString().padLeft(2, '0')}-${dateCalled!.day.toString().padLeft(2, '0')}",
        "date_next":
            "${dateFu!.year.toString().padLeft(4, '0')}-${dateFu!.month.toString().padLeft(2, '0')}-${dateFu!.day.toString().padLeft(2, '0')}",
        "catatan": noteCommunication,
        "alasan": reasonNotOrder,
        "status_order_value": sourceOrderValue,
        "media_value": mediaCommunicationValue,
        "status_prospek_value": statusProspectValue,
        "status_prospek": idStatusProspect,
        "media": idMediaCommunication,
        "status_order": idStatusOrder,
        "produk": idProduct,
        'jenis_kelamin': gender,
        'age': age
      };
}
