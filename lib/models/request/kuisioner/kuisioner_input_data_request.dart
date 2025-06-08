import 'dart:convert';

class KuisionerInputDataRequest {
  KuisionerInputDataRequest(
      {required this.idUser, required this.name, this.description});

  String name;
  String idUser;
  String? description;

  factory KuisionerInputDataRequest.fromRawJson(String str) =>
      KuisionerInputDataRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KuisionerInputDataRequest.fromJson(Map<String, dynamic> json) =>
      KuisionerInputDataRequest(
          idUser: json["nama_toko"],
          name: json["user_id"],
          description: json["deskripsi"]);

  Map<String, dynamic> toJson() =>
      {"user_id": idUser, "nama_toko": name, "deskripsi": description};
}
