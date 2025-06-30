import 'dart:convert';

class ShowCutiSalesRequest {
  ShowCutiSalesRequest({required this.id});

  String id;

  factory ShowCutiSalesRequest.fromRawJson(String str) =>
      ShowCutiSalesRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShowCutiSalesRequest.fromJson(Map<String, dynamic> json) =>
      ShowCutiSalesRequest(
        id: json["id_cuti"],
      );

  Map<String, dynamic> toJson() => {
        "id_cuti": id,
      };
}
