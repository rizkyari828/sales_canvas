// To parse this JSON data, do
//
//     final KuisionerResponse = KuisionerResponseFromJson(jsonString);

import 'dart:convert';

KuisionerResponse KuisionerResponseFromJson(String str) =>
    KuisionerResponse.fromJson(json.decode(str));

String KuisionerResponseToJson(KuisionerResponse data) =>
    json.encode(data.toJson());

class KuisionerResponse {
  KuisionerResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<ListKuisioner>? data;

  factory KuisionerResponse.fromJson(Map<String, dynamic> json) =>
      KuisionerResponse(
        status: json["status"],
        message: json["message"],
        data: List<ListKuisioner>.from(
            json["Data"].map((x) => ListKuisioner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ListKuisioner {
  ListKuisioner(
      {this.id,
      this.type,
      this.question,
      this.optionA,
      this.optionB,
      this.optionC,
      this.optionD});

  int? id;
  String? type;
  String? question;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;

  factory ListKuisioner.fromJson(Map<String, dynamic> json) => ListKuisioner(
        id: json["id"],
        type: json["type"],
        question: json["question"],
        optionA: json["optionA"],
        optionB: json["optionB"],
        optionC: json["optionC"],
        optionD: json["optionD"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "question": question,
        "optionA": optionA,
        "optionB": optionB,
        "optionC": optionC,
        "optionD": optionD,
      };
}
