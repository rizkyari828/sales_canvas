// To parse this JSON data, do
//
//     final showReliverResponse = showReliverResponseFromJson(jsonString);

import 'dart:convert';

ShowReliverResponse showReliverResponseFromJson(String str) =>
    ShowReliverResponse.fromJson(json.decode(str));

String showReliverResponseToJson(ShowReliverResponse data) =>
    json.encode(data.toJson());

class ShowReliverResponse {
  ShowReliverResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  String? status;
  String? message;
  bool? error;
  List<DataShowReliver>? data;

  factory ShowReliverResponse.fromJson(Map<String, dynamic> json) =>
      ShowReliverResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        error: json["error"] == null ? null : json["error"],
        data: json["Data"] == null
            ? null
            : List<DataShowReliver>.from(
                json["Data"].map((x) => DataShowReliver.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "error": error == null ? null : error,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataShowReliver {
  DataShowReliver(
      {this.id,
      this.namaEvent,
      this.tanggalAcara,
      this.lokasiAcara,
      this.kotaAcara,
      this.jamMulai,
      this.jamSelesai,
      this.foto,
      this.keterangan});

  int? id;
  String? namaEvent;
  DateTime? tanggalAcara;
  String? lokasiAcara;
  String? kotaAcara;
  String? jamMulai;
  String? jamSelesai;
  String? foto;
  String? keterangan;

  factory DataShowReliver.fromJson(Map<String, dynamic> json) =>
      DataShowReliver(
        id: json["id"] == null ? null : json["id"],
        namaEvent: json["nama_event"] == null ? null : json["nama_event"],
        tanggalAcara: json["tanggal_acara"] == null
            ? null
            : DateTime.parse(json["tanggal_acara"]),
        lokasiAcara: json["lokasi_acara"] == null ? null : json["lokasi_acara"],
        kotaAcara: json["kota_acara"] == null ? null : json["kota_acara"],
        jamMulai: json["jam_mulai"] == null ? null : json["jam_mulai"],
        jamSelesai: json["jam_selesai"] == null ? null : json["jam_selesai"],
        foto: json["foto"] == null ? null : json["foto"],
        keterangan: json["keterangan"] == null ? null : json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nama_event": namaEvent == null ? null : namaEvent,
        "tanggal_acara": tanggalAcara == null
            ? null
            : "${tanggalAcara?.year.toString().padLeft(4, '0')}-${tanggalAcara?.month.toString().padLeft(2, '0')}-${tanggalAcara?.day.toString().padLeft(2, '0')}",
        "lokasi_acara": lokasiAcara == null ? null : lokasiAcara,
        "kota_acara": kotaAcara == null ? null : kotaAcara,
        "jam_mulai": jamMulai == null ? null : jamMulai,
        "jam_selesai": jamSelesai == null ? null : jamSelesai,
        "foto": foto == null ? null : foto,
        "keterangan": keterangan == null ? null : keterangan,
      };
}
