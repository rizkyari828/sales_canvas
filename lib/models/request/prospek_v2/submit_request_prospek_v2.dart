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
      this.productName,
      this.totalTransaction,
      this.idStatusProspect,
      this.dateCalled,
      this.idMediaCommunication,
      this.dateFu,
      this.noteCommunication,
      this.statusOrder,
      this.reasonNotOrder});

  String? prospectName,
      productName,
      totalTransaction,
      dateCalled,
      dateFu,
      noteCommunication,
      reasonNotOrder,
      dateLastUpdate;
  String? idStatusProspect, userId, idMediaCommunication, statusOrder;

  factory SubmitProspekV2Request.fromJson(Map<String, dynamic> json) =>
      SubmitProspekV2Request(
        userId: json["user_id"],
        prospectName: json["nama"],
        productName: json["produk"],
        totalTransaction: json["estimasi_pinjaman"],
        idStatusProspect: json["status_prospek"],
        dateCalled: json["date_called"],
        idMediaCommunication: json["media"],
        dateFu: json["date_next"],
        noteCommunication: json["alasan"],
        statusOrder: json["status_order"],
        reasonNotOrder: json["reason_not_order"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "nama": prospectName,
        "produk": productName,
        "estimasi_pinjaman": totalTransaction,
        "status_prospek": idStatusProspect,
        "date_called": dateCalled,
        "media": idMediaCommunication,
        "date_next": dateFu,
        "alasan": noteCommunication,
        "status_order": statusOrder,
        "reason_not_order": reasonNotOrder,
      };
}
