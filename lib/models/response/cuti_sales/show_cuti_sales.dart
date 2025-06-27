// To parse this JSON data, do
//
//     final showCutiSalesResponse = showCutiSalesResponseFromJson(jsonString);

import 'dart:convert';

ShowCutiSalesResponse showCutiSalesResponseFromJson(String str) =>
    ShowCutiSalesResponse.fromJson(json.decode(str));

String showCutiSalesResponseToJson(ShowCutiSalesResponse data) =>
    json.encode(data.toJson());

class ShowCutiSalesResponse {
  String? status;
  String? message;
  bool? error;
  List<ShowDataCutiSales>? data;

  ShowCutiSalesResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory ShowCutiSalesResponse.fromJson(Map<String, dynamic> json) =>
      ShowCutiSalesResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<ShowDataCutiSales>.from(
                json["Data"]!.map((x) => ShowDataCutiSales.fromJson(x))),
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

class ShowDataCutiSales {
  dynamic tanggalPengajuan;
  DateTime? tanggalAwal;
  DateTime? tanggalAkhir;
  String? statusCuti;
  int? idCuti;
  String? user;
  String? keperluan;

  ShowDataCutiSales({
    this.tanggalPengajuan,
    this.tanggalAwal,
    this.tanggalAkhir,
    this.statusCuti,
    this.idCuti,
    this.user,
    this.keperluan,
  });

  factory ShowDataCutiSales.fromJson(Map<String, dynamic> json) =>
      ShowDataCutiSales(
        tanggalPengajuan: json["tanggal_pengajuan"],
        tanggalAwal: json["tanggal_awal"] == null
            ? null
            : DateTime.parse(json["tanggal_awal"]),
        tanggalAkhir: json["tanggal_akhir"] == null
            ? null
            : DateTime.parse(json["tanggal_akhir"]),
        statusCuti: json["status_cuti"],
        idCuti: json["id_cuti"],
        user: json["user"],
        keperluan: json["keperluan"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal_pengajuan": tanggalPengajuan,
        "tanggal_awal":
            "${tanggalAwal!.year.toString().padLeft(4, '0')}-${tanggalAwal!.month.toString().padLeft(2, '0')}-${tanggalAwal!.day.toString().padLeft(2, '0')}",
        "tanggal_akhir":
            "${tanggalAkhir!.year.toString().padLeft(4, '0')}-${tanggalAkhir!.month.toString().padLeft(2, '0')}-${tanggalAkhir!.day.toString().padLeft(2, '0')}",
        "status_cuti": statusCuti,
        "id_cuti": idCuti,
        "user": user,
        "keperluan": keperluan,
      };
}
