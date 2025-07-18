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
    this.data,
  });

  String? status;
  String? message;
  List<ProspekDetailV2>? data;

  factory ShowProspekV2Response.fromJson(Map<String, dynamic> json) =>
      ShowProspekV2Response(
        status: json["status"],
        message: json["message"],
        data: List<ProspekDetailV2>.from(
            json["Data"].map((x) => ProspekDetailV2.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProspekDetailV2 {
  int? id;
  String? prospectName;
  String? productName;
  String? totalTransaction;
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
  int? idSource;

  ProspekDetailV2({
    this.id,
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
    this.idSource,
  });

  factory ProspekDetailV2.fromJson(Map<String, dynamic> json) =>
      ProspekDetailV2(
        id: json["id"],
        prospectName: json["nama"],
        productName: json["product_name"],
        totalTransaction: json["estimasi_pinjaman"],
        dateCalled: json["date_called"] == null
            ? null
            : DateTime.parse(json["date_called"]),
        dateFu:
            json["date_fu"] == null ? null : DateTime.parse(json["date_fu"]),
        noteCommunication: json["note_communication"],
        reasonNotOrder: json["reason_not_order"],
        dateLastUpdate: json["date_last_update"],
        sourceOrderValue: json["source_order_value"],
        mediaCommunicationValue: json["media_communication_value"],
        statusProspectValue: json["status_prospect_value"],
        idStatusProspect: json["id_status_prospect"],
        idMediaCommunication: json["id_media_communication"],
        idSource: json["id_source"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": prospectName,
        "product_name": productName,
        "estimasi_pinjaman": totalTransaction,
        "date_called":
            "${dateCalled!.year.toString().padLeft(4, '0')}-${dateCalled!.month.toString().padLeft(2, '0')}-${dateCalled!.day.toString().padLeft(2, '0')}",
        "date_fu":
            "${dateFu!.year.toString().padLeft(4, '0')}-${dateFu!.month.toString().padLeft(2, '0')}-${dateFu!.day.toString().padLeft(2, '0')}",
        "note_communication": noteCommunication,
        "reason_not_order": reasonNotOrder,
        "source_order_value": sourceOrderValue,
        "media_communication_value": mediaCommunicationValue,
        "status_prospect_value": statusProspectValue,
        "id_status_prospect": idStatusProspect,
        "id_media_communication": idMediaCommunication,
        "id_source": idSource,
      };
}
