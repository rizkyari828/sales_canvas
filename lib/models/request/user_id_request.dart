import 'dart:convert';

class UserIdRequest {
  UserIdRequest({required this.id});

  String id;

  factory UserIdRequest.fromRawJson(String str) =>
      UserIdRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserIdRequest.fromJson(Map<String, dynamic> json) => UserIdRequest(
        id: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": id,
      };
}
