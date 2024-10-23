// To parse this JSON data, do
//
//     final kanvasResponse = kanvasResponseFromJson(jsonString);

import 'dart:convert';

KanvasResponse kanvasResponseFromJson(String str) =>
    KanvasResponse.fromJson(json.decode(str));

String kanvasResponseToJson(KanvasResponse data) => json.encode(data.toJson());

class KanvasResponse {
  String? status;
  String? message;
  bool? error;
  List<DataStore>? data;

  KanvasResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory KanvasResponse.fromJson(Map<String, dynamic> json) => KanvasResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<DataStore>.from(
                json["Data"]!.map((x) => DataStore.fromJson(x))),
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

class DataStore {
  int? tokoId;
  String? namaToko;
  String? alamatToko;
  String? pathToko;
  String? langToko;
  String? latToko;

  DataStore({
    this.tokoId,
    this.namaToko,
    this.alamatToko,
    this.pathToko,
    this.langToko,
    this.latToko,
  });

  factory DataStore.fromJson(Map<String, dynamic> json) => DataStore(
        tokoId: json["toko_id"],
        namaToko: json["nama_toko"],
        alamatToko: json["alamat_toko"],
        pathToko: json["path_toko"],
        langToko: json["lang_toko"],
        latToko: json["lat_toko"],
      );

  Map<String, dynamic> toJson() => {
        "toko_id": tokoId,
        "nama_toko": namaToko,
        "alamat_toko": alamatToko,
        "path_toko": pathToko,
        "lang_toko": langToko,
        "lat_toko": latToko,
      };
}
