// To parse this JSON data, do
//
//     final detailStoreResponse = detailStoreResponseFromJson(jsonString);

import 'dart:convert';

DetailStoreResponse detailStoreResponseFromJson(String str) => DetailStoreResponse.fromJson(json.decode(str));

String detailStoreResponseToJson(DetailStoreResponse data) => json.encode(data.toJson());

class DetailStoreResponse {
    String? status;
    String? message;
    bool? error;
    List<DetailStore>? data;

    DetailStoreResponse({
        this.status,
        this.message,
        this.error,
        this.data,
    });

    factory DetailStoreResponse.fromJson(Map<String, dynamic> json) => DetailStoreResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null ? [] : List<DetailStore>.from(json["Data"]!.map((x) => DetailStore.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
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
    List<Foto>? foto;

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
        this.foto,
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
        foto: json["Foto"] == null ? [] : List<Foto>.from(json["Foto"]!.map((x) => Foto.fromJson(x))),
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
        "Foto": foto == null ? [] : List<dynamic>.from(foto!.map((x) => x.toJson())),
    };
}

class Foto {
    dynamic img;

    Foto({
        this.img,
    });

    factory Foto.fromJson(Map<String, dynamic> json) => Foto(
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "img": img,
    };
}
