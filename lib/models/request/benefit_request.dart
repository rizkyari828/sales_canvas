import 'dart:convert';

class BenefitRequest {
  BenefitRequest({required this.id, this.token, this.month, this.search});

  String id;
  String? token;
  String? month;
  String? search;

  factory BenefitRequest.fromRawJson(String str) =>
      BenefitRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BenefitRequest.fromJson(Map<String, dynamic> json) => BenefitRequest(
      id: json["id_user"],
      token: json["token"],
      month: json["bulan"],
      search: json["nama"]);

  Map<String, dynamic> toJson() =>
      {"id_user": id, "token": token, "bulan": month, "nama": search};
}
