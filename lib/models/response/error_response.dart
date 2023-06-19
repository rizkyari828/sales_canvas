// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    this.status,
    this.message,
    this.error,
    // this.data,
  });

  String? status;
  String? message;
  bool? error;
  // List<Data>? data;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        // data: List<Data>.from(json["Data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error
        // "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.data,
  });

  String? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
