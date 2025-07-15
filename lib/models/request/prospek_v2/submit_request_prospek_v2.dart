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
      this.idSource,
      this.reasonNotOrder,
      this.dateLastUpdate});

  String? prospectName,
      productName,
      totalTransaction,
      dateCalled,
      dateFu,
      noteCommunication,
      reasonNotOrder,
      dateLastUpdate;
  int? idStatusProspect, userId, idMediaCommunication, idSource;

  factory SubmitProspekV2Request.fromJson(Map<String, dynamic> json) =>
      SubmitProspekV2Request(
        userId: json["user_id"],
        prospectName: json["prospect_name"],
        productName: json["product_name"],
        totalTransaction: json["total_transaction"],
        idStatusProspect: json["id_status_prospect"],
        dateCalled: json["date_called"],
        idMediaCommunication: json["id_media_communication"],
        dateFu: json["date_fu"],
        noteCommunication: json["note_communication"],
        idSource: json["id_source"],
        reasonNotOrder: json["reason_not_order"],
        dateLastUpdate: json["date_last_update"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "prospect_name": prospectName,
        "product_name": productName,
        "total_transaction": totalTransaction,
        "id_status_prospect": idStatusProspect,
        "date_called": dateCalled,
        "id_media_communication": idMediaCommunication,
        "date_fu": dateFu,
        "note_communication": noteCommunication,
        "id_source": idSource,
        "reason_not_order": reasonNotOrder,
        "date_last_update": dateLastUpdate,
      };
}
