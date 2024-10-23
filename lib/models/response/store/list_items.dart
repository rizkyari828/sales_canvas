// To parse this JSON data, do
//
//     final listItemsResponse = listItemsResponseFromJson(jsonString);

import 'dart:convert';

ListItemsResponse listItemsResponseFromJson(String str) => ListItemsResponse.fromJson(json.decode(str));

String listItemsResponseToJson(ListItemsResponse data) => json.encode(data.toJson());

class ListItemsResponse {
    String? status;
    String? message;
    bool? error;
    List<Items>? data;

    ListItemsResponse({
        this.status,
        this.message,
        this.error,
        this.data,
    });

    factory ListItemsResponse.fromJson(Map<String, dynamic> json) => ListItemsResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null ? [] : List<Items>.from(json["Data"]!.map((x) => Items.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Items {
    int? idBarang;
    String? namaBarang;
    int? qtyNow;

    Items({
        this.idBarang,
        this.namaBarang,
        this.qtyNow,
    });

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        idBarang: json["id_barang"],
        namaBarang: json["nama_barang"],
        qtyNow: json["qty_now"],
    );

    Map<String, dynamic> toJson() => {
        "id_barang": idBarang,
        "nama_barang": namaBarang,
        "qty_now": qtyNow,
    };
}
