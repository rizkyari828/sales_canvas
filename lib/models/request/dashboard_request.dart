import 'dart:convert';

class DashboardRequest {
  DashboardRequest({required this.id, this.type});

  String id;
  String? type;

  factory DashboardRequest.fromRawJson(String str) =>
      DashboardRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DashboardRequest.fromJson(Map<String, dynamic> json) =>
      DashboardRequest(id: json["id_user"], type: json["typ"]);

  Map<String, dynamic> toJson() => {"id_user": id, "typ": type};
}
