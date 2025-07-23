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
        error: json["error"],
        data: json.containsKey("Data") && json["Data"] != null
            ? List<ProspekDetailV2>.from(
                json["Data"].map((x) => ProspekDetailV2.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "Data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : [],
      };
}

class ProspekDetailV2 {
  int? id;
  int? idLead;
  String? prospectName;
  String? productName;
  int? totalTransaction;
  DateTime? dateCalled;
  DateTime? dateFu;
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

  ProspekDetailV2({
    this.id,
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
  });

  factory ProspekDetailV2.fromJson(Map<String, dynamic> json) {
    return ProspekDetailV2(
      id: json["id_prospek"] is int
          ? json["id_prospek"]
          : int.tryParse('${json["id_prospek"]}'),
      idLead: json["id_leads"] is int
          ? json["id_leads"]
          : int.tryParse('${json["id_leads"]}'),
      prospectName: json["nama"],
      productName: json["produk_value"],
      totalTransaction: json["estimasi_pinjaman"] is int
          ? json["estimasi_pinjaman"]
          : int.tryParse('${json["estimasi_pinjaman"]}'),
      dateCalled: _parseDate(json["cdate"]),
      dateFu: _parseDate(json["date_next"]),
      noteCommunication: json["catatan"],
      reasonNotOrder: json["alasan"],
      dateLastUpdate: json["date_last_update"],
      sourceOrderValue: json["status_order_value"],
      mediaCommunicationValue: json["media_value"],
      statusProspectValue:
          json["status_prospek_value"] ?? json["status_prospek_new"],
      idStatusProspect: json["status_prospek"] is int
          ? json["status_prospek"]
          : int.tryParse('${json["status_prospek"]}'),
      idMediaCommunication: json["media"] is int
          ? json["media"]
          : int.tryParse('${json["media"]}'),
      idStatusOrder: json["status_order"] is int
          ? json["status_order"]
          : int.tryParse('${json["status_order"]}'),
      idProduct: json["produk"] is int
          ? json["produk"]
          : int.tryParse('${json["produk"]}'),
    );
  }

  Map<String, dynamic> toJson() => {
        "id_prospek": id,
        "id_leads": idLead,
        "nama": prospectName,
        "produk_value": productName,
        "estimasi_pinjaman": totalTransaction,
        "cdate": dateCalled != null ? _formatDate(dateCalled!) : null,
        "date_next": dateFu != null ? _formatDate(dateFu!) : null,
        "catatan": noteCommunication,
        "alasan": reasonNotOrder,
        "date_last_update": dateLastUpdate,
        "status_order_value": sourceOrderValue,
        "media_value": mediaCommunicationValue,
        "status_prospek_value": statusProspectValue,
        "status_prospek": idStatusProspect,
        "media": idMediaCommunication,
        "status_order": idStatusOrder,
        "produk": idProduct,
      };

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  static String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }
}
