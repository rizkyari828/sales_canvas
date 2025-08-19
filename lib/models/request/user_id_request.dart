import 'dart:convert';

class UserIdRequest {
  UserIdRequest({
    required this.id,
    this.page,
    this.limit,
    this.type, // tambahkan field opsional
  });

  String id;
  String? page;
  String? limit;
  String? type; // field opsional

  factory UserIdRequest.fromRawJson(String str) =>
      UserIdRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserIdRequest.fromJson(Map<String, dynamic> json) => UserIdRequest(
        id: json["user_id"],
        page: json["page"],
        limit: json["limit"],
        type: json["type"], // mapping dari json jika ada
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "user_id": id,
      "page": page,
      "limit": limit,
    };

    // hanya sertakan "type" kalau tidak null
    if (type != null) {
      data["type"] = type;
    }

    return data;
  }
}
