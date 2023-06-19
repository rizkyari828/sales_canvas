// To parse this JSON data, do
//
//     final prospekResponse = prospekResponseFromJson(jsonString);

import 'dart:convert';

ProspekResponse prospekResponseFromJson(String str) => ProspekResponse.fromJson(json.decode(str));

String prospekResponseToJson(ProspekResponse data) => json.encode(data.toJson());

class ProspekResponse {
    ProspekResponse({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<ListProspek>? data;

    factory ProspekResponse.fromJson(Map<String, dynamic> json) => ProspekResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["Data"] == null ? null : List<ListProspek>.from(json["Data"].map((x) => ListProspek.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "Data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ListProspek {
    ListProspek({
        this.id,
        this.noTrans,
        this.nama,
        this.cdate,
        this.namaLengkap,
        this.type,
        this.nobpkp,
        this.merek,
        this.phone,
        this.userid,
        this.status,
    });

    int? id;
    String? noTrans;
    String? nama;
    DateTime? cdate;
    String? namaLengkap;
    String? type;
    String? nobpkp;
    String? merek;
    String? phone;
    String? userid;
    String? status;

    factory ListProspek.fromJson(Map<String, dynamic> json) => ListProspek(
        id: json["id"] == null ? null : json["id"],
        noTrans: json["no_trans"] == null ? null : json["no_trans"],
        nama: json["nama"] == null ? null : json["nama"],
        cdate: json["cdate"] == null ? null : DateTime.parse(json["cdate"]),
        namaLengkap: json["nama_lengkap"] == null ? null : json["nama_lengkap"],
        type: json["type"] == null ? null : json["type"],
        nobpkp: json["nobpkp"] == null ? null : json["nobpkp"],
        merek: json["merek"] == null ? null : json["merek"],
        phone: json["phone"] == null ? null : json["phone"],
        userid: json["userid"] == null ? null : json["userid"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "no_trans": noTrans == null ? null : noTrans,
        "nama": nama == null ? null : nama,
        "cdate": cdate == null ? null : cdate?.toIso8601String(),
        "nama_lengkap": namaLengkap == null ? null : namaLengkap,
        "type": type == null ? null : type,
        "nobpkp": nobpkp == null ? null : nobpkp,
        "merek": merek == null ? null : merek,
        "phone": phone == null ? null : phone,
        "userid": userid == null ? null : userid,
        "status": status == null ? null : status,
    };
}
