import 'dart:convert';

class ShowProspectV2Request {
  ShowProspectV2Request({required this.id});

  String id;

  factory ShowProspectV2Request.fromRawJson(String str) =>
      ShowProspectV2Request.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShowProspectV2Request.fromJson(Map<String, dynamic> json) =>
      ShowProspectV2Request(
        id: json["id_prospek"],
      );

  Map<String, dynamic> toJson() => {
        "id_prospek": id,
      };
}
