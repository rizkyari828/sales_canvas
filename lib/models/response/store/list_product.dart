// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) =>
    json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  String? status;
  String? message;
  bool? error;
  List<DataProduct>? data;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        error: json["error"] == null ? null : json["error"],
        data: json["Data"] == null
            ? null
            : List<DataProduct>.from(
                json["Data"].map((x) => DataProduct.fromJson(x))),
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

class DataProduct {
  DataProduct({
    this.id,
    this.kode,
    this.name,
    this.type,
    this.price,
    this.photo,
    required int stock,
  }) : stock = stock.obs;

  int? id;
  String? kode;
  String? name;
  String? type;
  int? price;
  String? photo;
  RxInt stock = 0.obs;

  factory DataProduct.fromJson(Map<String, dynamic> json) => DataProduct(
        id: json["id"] == null ? null : json["id"],
        kode: json["kode"] == null ? null : json["kode"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        price: json["price"] == null ? null : json["price"],
        photo: json["photo"] == null ? null : json["photo"],
        stock: json["stock"] == null ? 0 : json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "kode": kode == null ? null : kode,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "price": price == null ? null : price,
        "photo": photo == null ? null : photo,
        "stock": stock.value,
      };
}
