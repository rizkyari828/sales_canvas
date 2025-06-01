import 'dart:convert';

class KuisionerRequest {
  KuisionerRequest({required this.idUser, required this.idKuisioner, this.answer});

  String idUser;
  String idKuisioner;
  String? answer;

  factory KuisionerRequest.fromRawJson(String str) =>
      KuisionerRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KuisionerRequest.fromJson(Map<String, dynamic> json) =>
      KuisionerRequest(
          idUser: json["id_user"],
          answer: json["token"],
          idKuisioner: json["id_kuisionner"]);

  Map<String, dynamic> toJson() =>
      {"id_user": idUser, "answer": answer, "id_kuisioneer": idKuisioner};
}
