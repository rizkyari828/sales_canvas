import 'dart:convert';

class ShowLeaveRequest {
  ShowLeaveRequest({required this.id});

  String id;

  factory ShowLeaveRequest.fromRawJson(String str) =>
      ShowLeaveRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShowLeaveRequest.fromJson(Map<String, dynamic> json) =>
      ShowLeaveRequest(
        id: json["id_ijin"],
      );

  Map<String, dynamic> toJson() => {
        "id_ijin": id,
      };
}
