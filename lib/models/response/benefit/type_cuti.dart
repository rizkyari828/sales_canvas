// To parse this JSON data, do
//
//     final typeCutiResponse = typeCutiResponseFromJson(jsonString);

import 'dart:convert';

TypeCutiResponse typeCutiResponseFromJson(String str) => TypeCutiResponse.fromJson(json.decode(str));

String typeCutiResponseToJson(TypeCutiResponse data) => json.encode(data.toJson());

class TypeCutiResponse {
    TypeCutiResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    List<DataTypeCuti>? data;

    factory TypeCutiResponse.fromJson(Map<String, dynamic> json) => TypeCutiResponse(
        error: json["error"],
        message: json["message"],
        data: List<DataTypeCuti>.from(json["data"].map((x) => DataTypeCuti.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataTypeCuti {
    DataTypeCuti({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory DataTypeCuti.fromJson(Map<String, dynamic> json) => DataTypeCuti(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
