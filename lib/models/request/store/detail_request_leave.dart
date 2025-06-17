import 'dart:convert';

class ShowDetailKunjunganRequest {
  ShowDetailKunjunganRequest(
      {required this.id, required this.type, required this.idUser});

  String id;
  String type;
  String idUser;

  factory ShowDetailKunjunganRequest.fromRawJson(String str) =>
      ShowDetailKunjunganRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShowDetailKunjunganRequest.fromJson(Map<String, dynamic> json) =>
      ShowDetailKunjunganRequest(
        id: json["id_toko"],
        type: json["typ_list"],
        idUser: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id_toko": id,
        "typ_list": type,
        "user_id": idUser,
      };
}
