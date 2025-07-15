// To parse this JSON data, do
//
//     final ProspekV2Response = ProspekV2ResponseFromJson(jsonString);

import 'dart:convert';

ProspekV2Response prospekV2ResponseFromJson(String str) => ProspekV2Response.fromJson(json.decode(str));

String prospekV2ResponseToJson(ProspekV2Response data) => json.encode(data.toJson());

class ProspekV2Response {
    ProspekV2Response({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    List<ListProspekV2>? data;

    factory ProspekV2Response.fromJson(Map<String, dynamic> json) => ProspekV2Response(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["Data"] == null ? null : List<ListProspekV2>.from(json["Data"].map((x) => ListProspekV2.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "Data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ListProspekV2 {
    ListProspekV2({
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

    factory ListProspekV2.fromJson(Map<String, dynamic> json) => ListProspekV2(
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
