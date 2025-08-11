// To parse this JSON data, do
//
//     final SubmitProspekV2Request = SubmitProspekV2RequestFromJson(jsonString);

import 'dart:convert';

SubmitProspekV2Request submitProspekV2RequestFromJson(String str) =>
    SubmitProspekV2Request.fromJson(json.decode(str));

String submitProspekV2RequestToJson(SubmitProspekV2Request data) =>
    json.encode(data.toJson());

class SubmitProspekV2Request {
  SubmitProspekV2Request(
      {this.userId,
      this.prospectName,
      this.idProductName,
      this.otherProduct,
      this.totalTransaction,
      this.idStatusProspect,
      // this.dateCalled,
      this.idMediaCommunication,
      this.dateFu,
      this.noteCommunication,
      this.statusOrder,
      this.reasonNotOrder,
      this.id,
      this.idLead,
      this.gender,
      this.age});

  String? prospectName,
      // productName,
      totalTransaction,
      // dateCalled,
      dateFu,
      noteCommunication,
      reasonNotOrder,
      dateLastUpdate,
      otherProduct;
  String? idStatusProspect,
      userId,
      idMediaCommunication,
      statusOrder,
      id,
      idLead,
      idProductName,
      gender,
      age;

  factory SubmitProspekV2Request.fromJson(Map<String, dynamic> json) =>
      SubmitProspekV2Request(
          userId: json["user_id"],
          prospectName: json["nama"],
          idProductName: json["produk"],
          otherProduct: json["produk_lainnya"],
          totalTransaction: json["estimasi_pinjaman"],
          idStatusProspect: json["status_prospek"],
          // dateCalled: json["date_called"],
          idMediaCommunication: json["media"],
          dateFu: json["date_next"],
          noteCommunication: json["catatan"],
          statusOrder: json["status_order"],
          reasonNotOrder: json["alasan"],
          id: json["id_prospek"],
          idLead: json["id_leads"],
          gender: json["jenis_kelamin"],
          age: json["umur"]);

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "nama": prospectName,
        "produk": idProductName,
        "produk_lainnya": otherProduct,
        "estimasi_pinjaman": totalTransaction,
        "status_prospek": idStatusProspect,
        // "date_called": dateCalled,
        "media": idMediaCommunication,
        "date_next": dateFu,
        "catatan": noteCommunication,
        "status_order": statusOrder,
        "alasan": reasonNotOrder,
        "id_prospek": id,
        "id_leads": idLead,
        "jenis_kelamin": gender,
        "umur": age
      };
}
