// To parse this JSON data, do
//
//     final storeResponse = storeResponseFromJson(jsonString);

import 'dart:convert';

StoreResponse storeResponseFromJson(String str) =>
    StoreResponse.fromJson(json.decode(str));

String storeResponseToJson(StoreResponse data) => json.encode(data.toJson());

class StoreResponse {
  StoreResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  String? status;
  String? message;
  bool? error;
  List<DataStore>? data;

  factory StoreResponse.fromJson(Map<String, dynamic> json) => StoreResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        error: json["error"] == null ? null : json["error"],
        data: json["Data"] == null
            ? null
            : List<DataStore>.from(
                json["Data"].map((x) => DataStore.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "error": error == null ? null : error,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataStore {
  DataStore({
    this.id,
    this.kode,
    this.name,
    this.type,
    this.photo,
    this.latitude,
    this.logitude,
    this.address,
  });

  int? id;
  String? kode;
  String? name;
  String? latitude;
  String? logitude;
  String? address;
  String? type;
  String? photo;

  factory DataStore.fromJson(Map<String, dynamic> json) => DataStore(
        id: json["id"] == null ? null : json["id"],
        kode: json["kode"] == null ? null : json["kode"],
        name: json["name"] == null ? null : json["name"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        logitude: json["logitude"] == null ? null : json["logitude"],
        address: json["address"] == null ? null : json["address"],
        type: json["type"] == null ? null : json["type"],
        photo: json["photo"] == null ? null : json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "kode": kode == null ? null : kode,
        "name": name == null ? null : name,
        "latitude": latitude == null ? null : latitude,
        "logitude": logitude == null ? null : logitude,
        "address": address == null ? null : address,
        "type": type == null ? null : type,
        "photo": photo == null ? null : photo,
      };
}
