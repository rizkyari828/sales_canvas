// To parse this JSON data, do
//
//     final masterData2Response = masterData2ResponseFromJson(jsonString);

import 'dart:convert';

MasterData2Response masterData2ResponseFromJson(String str) => MasterData2Response.fromJson(json.decode(str));

String masterData2ResponseToJson(MasterData2Response data) => json.encode(data.toJson());

class MasterData2Response {
    String? status;
    String? message;
    bool? error;
    List<MasterData2>? data;

    MasterData2Response({
        this.status,
        this.message,
        this.error,
        this.data,
    });

    factory MasterData2Response.fromJson(Map<String, dynamic> json) => MasterData2Response(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null ? [] : List<MasterData2>.from(json["Data"]!.map((x) => MasterData2.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class MasterData2 {
    int? id;
    String? nama;
    String? flag;

    MasterData2({
        this.id,
        this.nama,
        this.flag,
    });

    factory MasterData2.fromJson(Map<String, dynamic> json) => MasterData2(
        id: json["id"],
        nama: json["nama"],
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "flag": flag,
    };
}
