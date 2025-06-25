// To parse this JSON data, do
//
//     final showCutiSalesResponse = showCutiSalesResponseFromJson(jsonString);

import 'dart:convert';

ShowCutiSalesResponse showCutiSalesResponseFromJson(String str) => ShowCutiSalesResponse.fromJson(json.decode(str));

String showCutiSalesResponseToJson(ShowCutiSalesResponse data) => json.encode(data.toJson());

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

    factory ShowCutiSalesResponse.fromJson(Map<String, dynamic> json) => ShowCutiSalesResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null ? [] : List<ShowDataCutiSales>.from(json["Data"]!.map((x) => ShowDataCutiSales.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ShowDataCutiSales {
    DateTime? tanggalLembur;
    String? jamIn;
    String? jamOut;
    String? statusLembur;
    int? idLembur;

    ShowDataCutiSales({
        this.tanggalLembur,
        this.jamIn,
        this.jamOut,
        this.statusLembur,
        this.idLembur,
    });

    factory ShowDataCutiSales.fromJson(Map<String, dynamic> json) => ShowDataCutiSales(
        tanggalLembur: json["tanggal_lembur"] == null ? null : DateTime.parse(json["tanggal_lembur"]),
        jamIn: json["jam_in"],
        jamOut: json["jam_out"],
        statusLembur: json["status_lembur"],
        idLembur: json["id_lembur"],
    );

    Map<String, dynamic> toJson() => {
        "tanggal_lembur": "${tanggalLembur!.year.toString().padLeft(4, '0')}-${tanggalLembur!.month.toString().padLeft(2, '0')}-${tanggalLembur!.day.toString().padLeft(2, '0')}",
        "jam_in": jamIn,
        "jam_out": jamOut,
        "status_lembur": statusLembur,
        "id_lembur": idLembur,
    };
}
