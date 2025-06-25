// To parse this JSON data, do
//
//     final cutiSalesResponse = cutiSalesResponseFromJson(jsonString);

import 'dart:convert';

CutiSalesResponse cutiSalesResponseFromJson(String str) =>
    CutiSalesResponse.fromJson(json.decode(str));

String cutiSalesResponseToJson(CutiSalesResponse data) =>
    json.encode(data.toJson());

class CutiSalesResponse {
  String? status;
  String? message;
  bool? error;
  List<DataCutiSales>? data;

  CutiSalesResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory CutiSalesResponse.fromJson(Map<String, dynamic> json) =>
      CutiSalesResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<DataCutiSales>.from(
                json["Data"]!.map((x) => DataCutiSales.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "Data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataCutiSales {
  dynamic tanggalPengajuan;
  DateTime? tanggalAwal;
  DateTime? tanggalAkhir;
  String? statusCuti;
  String? user;
  int? idCuti;

  DataCutiSales({
    this.tanggalPengajuan,
    this.tanggalAwal,
    this.tanggalAkhir,
    this.statusCuti,
    this.user,
    this.idCuti,
  });

  factory DataCutiSales.fromJson(Map<String, dynamic> json) => DataCutiSales(
        tanggalPengajuan: json["tanggal_pengajuan"],
        tanggalAwal: json["tanggal_awal"] == null
            ? null
            : DateTime.parse(json["tanggal_awal"]),
        tanggalAkhir: json["tanggal_akhir"] == null
            ? null
            : DateTime.parse(json["tanggal_akhir"]),
        statusCuti: json["status_cuti"],
        user: json["user"],
        idCuti: json["id_cuti"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal_pengajuan": tanggalPengajuan,
        "tanggal_awal":
            "${tanggalAwal!.year.toString().padLeft(4, '0')}-${tanggalAwal!.month.toString().padLeft(2, '0')}-${tanggalAwal!.day.toString().padLeft(2, '0')}",
        "tanggal_akhir":
            "${tanggalAkhir!.year.toString().padLeft(4, '0')}-${tanggalAkhir!.month.toString().padLeft(2, '0')}-${tanggalAkhir!.day.toString().padLeft(2, '0')}",
        "status_cuti": statusCuti,
        "user": user,
        "id_cuti": idCuti,
      };
}
