// To parse this JSON data, do
//
//     final SubmitDialogMoodRequest = SubmitDialogMoodRequestFromJson(jsonString);

import 'dart:convert';

SubmitDialogMoodRequest submitDialogMoodRequestFromJson(String str) =>
    SubmitDialogMoodRequest.fromJson(json.decode(str));

String submitDialogMoodRequestToJson(SubmitDialogMoodRequest data) =>
    json.encode(data.toJson());

class SubmitDialogMoodRequest {
  SubmitDialogMoodRequest({
    this.idUser,
    this.value,
  });

  String? idUser;
  String? value;

  factory SubmitDialogMoodRequest.fromJson(Map<String, dynamic> json) =>
      SubmitDialogMoodRequest(
        idUser: json["user_id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": idUser,
        "value": value,
      };
}
