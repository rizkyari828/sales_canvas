import 'dart:convert';

class ShowLemburRequest {
  ShowLemburRequest({required this.id});

  String id;

  factory ShowLemburRequest.fromRawJson(String str) =>
      ShowLemburRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShowLemburRequest.fromJson(Map<String, dynamic> json) =>
      ShowLemburRequest(
        id: json["id_lembur"],
      );

  Map<String, dynamic> toJson() => {
        "id_lembur": id,
      };
}
