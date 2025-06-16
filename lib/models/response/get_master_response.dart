// To parse this JSON data, do
//
//     final getMasterResponse = getMasterResponseFromJson(jsonString);

import 'dart:convert';

GetMasterResponse getMasterResponseFromJson(String str) => GetMasterResponse.fromJson(json.decode(str));

String getMasterResponseToJson(GetMasterResponse data) => json.encode(data.toJson());

class GetMasterResponse {
    String? status;
    String? message;
    bool? error;
    List<DataMaster>? data;

    GetMasterResponse({
        this.status,
        this.message,
        this.error,
        this.data,
    });

    factory GetMasterResponse.fromJson(Map<String, dynamic> json) => GetMasterResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null ? [] : List<DataMaster>.from(json["Data"]!.map((x) => DataMaster.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataMaster {
    int? id;
    String? nama;
    String? flag;
    String? namaSc;

    DataMaster({
        this.id,
        this.nama,
        this.flag,
        this.namaSc,
    });

    factory DataMaster.fromJson(Map<String, dynamic> json) => DataMaster(
        id: json["id"],
        nama: json["nama"],
        flag: json["flag"],
        namaSc: json["namaSc"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "flag": flag,
        "namaSc": namaSc,
    };
}
