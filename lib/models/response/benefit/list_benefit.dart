// To parse this JSON data, do
//
//     final benefitResponse = benefitResponseFromJson(jsonString);

import 'dart:convert';

BenefitResponse benefitResponseFromJson(String str) =>
    BenefitResponse.fromJson(json.decode(str));

String benefitResponseToJson(BenefitResponse data) =>
    json.encode(data.toJson());

class BenefitResponse {
  BenefitResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<ListBenefit>? data;

  factory BenefitResponse.fromJson(Map<String, dynamic> json) =>
      BenefitResponse(
        status: json["status"],
        message: json["message"],
        data: List<ListBenefit>.from(
            json["Data"].map((x) => ListBenefit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ListBenefit {
  ListBenefit({this.id, this.noTrans, this.dateBoking, this.name});

  int? id;
  String? noTrans;
  DateTime? dateBoking;
  String? name;

  factory ListBenefit.fromJson(Map<String, dynamic> json) => ListBenefit(
        id: json["id"],
        noTrans: json["no_trans"],
        dateBoking: DateTime.parse(json["date_boking"]),
        name: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no_trans": noTrans,
        "date_boking":
            "${dateBoking?.year.toString().padLeft(4, '0')}-${dateBoking?.month.toString().padLeft(2, '0')}-${dateBoking?.day.toString().padLeft(2, '0')}",
        "nama": name,
      };
}
