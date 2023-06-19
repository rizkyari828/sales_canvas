// To parse this JSON data, do
//
//     final getListRequest = getListRequestFromJson(jsonString);

import 'dart:convert';

GetListRequest getListRequestFromJson(String str) =>
    GetListRequest.fromJson(json.decode(str));

String getListRequestToJson(GetListRequest data) => json.encode(data.toJson());

class GetListRequest {
  GetListRequest({
    this.id,
    this.token,
    this.month,
    this.status,
    this.type,
  });

  String? id;
  String? token;
  String? month;
  String? status;
  String? type;

  factory GetListRequest.fromJson(Map<String, dynamic> json) => GetListRequest(
      id: json["id"],
      token: json["token"],
      month: json["bulan"],
      status: json["status"],
      type: json['tipe']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "bulan": month,
        "status": status,
        "tipe": type
      };
}
