// To parse this JSON data, do
//
//     final showLemburResponse = showLemburResponseFromJson(jsonString);

import 'dart:convert';

ShowLemburResponse showLemburResponseFromJson(String str) => ShowLemburResponse.fromJson(json.decode(str));

String showLemburResponseToJson(ShowLemburResponse data) => json.encode(data.toJson());

class ShowLemburResponse {
    ShowLemburResponse({
        this.status,
        this.message,
        this.error,
        this.data,
    });

    String? status;
    String? message;
    bool? error;
    List<DataLembur>? data;

    factory ShowLemburResponse.fromJson(Map<String, dynamic> json) => ShowLemburResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        error: json["error"] == null ? null : json["error"],
        data: json["Data"] == null ? null : List<DataLembur>.from(json["Data"].map((x) => DataLembur.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "error": error == null ? null : error,
        "Data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataLembur {
    DataLembur({
        this.id,
        this.kodeIjin,
        this.dateIn,
        this.dateOut,
        this.keterangan,
    });

    int? id;
    String? kodeIjin;
    DateTime? dateIn;
    DateTime? dateOut;
    String? keterangan;

    factory DataLembur.fromJson(Map<String, dynamic> json) => DataLembur(
        id: json["id"] == null ? null : json["id"],
        kodeIjin: json["kode_ijin"] == null ? null : json["kode_ijin"],
        dateIn: json["date_in"] == null ? null : DateTime.parse(json["date_in"]),
        dateOut: json["date_out"] == null ? null : DateTime.parse(json["date_out"]),
        keterangan: json["keterangan"] == null ? null : json["keterangan"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "kode_ijin": kodeIjin == null ? null : kodeIjin,
        "date_in": dateIn == null ? null : "${dateIn?.year.toString().padLeft(4, '0')}-${dateIn?.month.toString().padLeft(2, '0')}-${dateIn?.day.toString().padLeft(2, '0')}",
        "date_out": dateOut == null ? null : "${dateOut?.year.toString().padLeft(4, '0')}-${dateOut?.month.toString().padLeft(2, '0')}-${dateOut?.day.toString().padLeft(2, '0')}",
        "keterangan": keterangan == null ? null : keterangan,
    };
}
