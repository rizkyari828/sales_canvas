import 'dart:convert';

class ListKuisionerRequest {
  ListKuisionerRequest({this.id, this.limit, this.page});

  int? page;
  int? limit;
  int? id;

  factory ListKuisionerRequest.fromRawJson(String str) =>
      ListKuisionerRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListKuisionerRequest.fromJson(Map<String, dynamic> json) =>
      ListKuisionerRequest(
        id: json["id_group"],
        limit: json["limit"],
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        "id_group": id,
        "limit": limit,
        "page": page,
      };
}
