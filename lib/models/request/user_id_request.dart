import 'dart:convert';

class UserIdRequest {
  UserIdRequest({required this.id, this.page, this.limit});

  String id;
  String? page;
  String? limit;

  factory UserIdRequest.fromRawJson(String str) =>
      UserIdRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserIdRequest.fromJson(Map<String, dynamic> json) => UserIdRequest(
      id: json["user_id"], page: json["page"], limit: json["limit"]);

  Map<String, dynamic> toJson() =>
      {"user_id": id, "page": page, "limit": limit};
}
