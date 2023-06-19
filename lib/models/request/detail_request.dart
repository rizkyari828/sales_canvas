import 'dart:convert';

class ShowEventRequest {
  ShowEventRequest({required this.id, this.token});

  String id;
  String? token;

  factory ShowEventRequest.fromRawJson(String str) =>
      ShowEventRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShowEventRequest.fromJson(Map<String, dynamic> json) =>
      ShowEventRequest(
        id: json["id_event"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id_event": id,
        "token": token,
      };
}
