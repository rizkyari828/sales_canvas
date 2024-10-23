// To parse this JSON data, do
//
//     final qtyUpdateRequest = qtyUpdateRequestFromJson(jsonString);

import 'dart:convert';

QtyUpdateRequest qtyUpdateRequestFromJson(String str) =>
    QtyUpdateRequest.fromJson(json.decode(str));

String qtyUpdateRequestToJson(QtyUpdateRequest data) =>
    json.encode(data.toJson());

class QtyUpdateRequest {
  String? userId;
  String? barangId;
  String? tokoId;
  String? qty;

  QtyUpdateRequest({
    this.userId,
    this.barangId,
    this.tokoId,
    this.qty,
  });

  factory QtyUpdateRequest.fromJson(Map<String, dynamic> json) =>
      QtyUpdateRequest(
        userId: json["user_id"],
        barangId: json["barang_id"],
        tokoId: json["toko_id"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "barang_id": barangId,
        "toko_id": tokoId,
        "qty": qty,
      };
}
