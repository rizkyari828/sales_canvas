import 'dart:convert';

class IdRequest {
  IdRequest({required this.id, this.token, this.month});

  String id;
  String? token;
  String? month;

  factory IdRequest.fromRawJson(String str) =>
      IdRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IdRequest.fromJson(Map<String, dynamic> json) => IdRequest(
        id: json["id_user"],
        token: json["token"],
        month: json["bulan"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": id,
        "token": token,
        "bulan": month,
      };
}
