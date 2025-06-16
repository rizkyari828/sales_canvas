// To parse this JSON data, do
//
//     final detailStoreResponseResponse = detailStoreResponseResponseFromJson(jsonString);

import 'dart:convert';

DetailStoreResponseResponse detailStoreResponseResponseFromJson(String str) =>
    DetailStoreResponseResponse.fromJson(json.decode(str));

String detailStoreResponseResponseToJson(DetailStoreResponseResponse data) =>
    json.encode(data.toJson());

class DetailStoreResponseResponse {
  String? status;
  String? message;
  bool? error;
  List<DetailStore>? data;

  DetailStoreResponseResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory DetailStoreResponseResponse.fromJson(Map<String, dynamic> json) =>
      DetailStoreResponseResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<DetailStore>.from(
                json["Data"]!.map((x) => DetailStore.fromJson(x))),
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

class DetailStore {
  int? tokoId;
  String? namaToko;
  String? alamatToko;
  dynamic pathToko;
  String? langToko;
  String? latToko;
  String? typList;
  String? catatan;
  String? rencana;

  DetailStore({
    this.tokoId,
    this.namaToko,
    this.alamatToko,
    this.pathToko,
    this.langToko,
    this.latToko,
    this.typList,
    this.catatan,
    this.rencana,
  });

  factory DetailStore.fromJson(Map<String, dynamic> json) => DetailStore(
        tokoId: json["toko_id"],
        namaToko: json["nama_toko"],
        alamatToko: json["alamat_toko"],
        pathToko: json["path_toko"],
        langToko: json["lang_toko"],
        latToko: json["lat_toko"],
        typList: json["typ_list"],
        catatan: json["catatan"],
        rencana: json["rencana"],
      );

  Map<String, dynamic> toJson() => {
        "toko_id": tokoId,
        "nama_toko": namaToko,
        "alamat_toko": alamatToko,
        "path_toko": pathToko,
        "lang_toko": langToko,
        "lat_toko": latToko,
        "typ_list": typList,
        "catatan": catatan,
        "rencana": rencana,
      };
}
