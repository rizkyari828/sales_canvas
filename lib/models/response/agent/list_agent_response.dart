// To parse this JSON data, do
//
//     final AgentResponse = AgentResponseFromJson(jsonString);

import 'dart:convert';

AgentResponse agentResponseFromJson(String str) =>
    AgentResponse.fromJson(json.decode(str));

String agentResponseToJson(AgentResponse data) => json.encode(data.toJson());

class AgentResponse {
  String? status;
  String? message;
  bool? error;
  List<DataAgent>? data;

  AgentResponse({
    this.status,
    this.message,
    this.error,
    this.data,
  });

  factory AgentResponse.fromJson(Map<String, dynamic> json) => AgentResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["Data"] == null
            ? []
            : List<DataAgent>.from(
                json["Data"]!.map((x) => DataAgent.fromJson(x))),
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

class DataAgent {
  String? fullName;
  String? agentName;
  String? email;
  String? alamat;
  String? placement;
  dynamic joinDate;
  String? typeAgentId;
  String? registerBy;
  String? statusActiveId;
  List<Foto>? foto;
  List<Foto>? signature;

  DataAgent({
    this.fullName,
    this.agentName,
    this.email,
    this.alamat,
    this.placement,
    this.joinDate,
    this.typeAgentId,
    this.registerBy,
    this.statusActiveId,
    this.foto,
    this.signature,
  });

  factory DataAgent.fromJson(Map<String, dynamic> json) => DataAgent(
        fullName: json["full_name"],
        agentName: json["agent_name"],
        email: json["email"],
        alamat: json["alamat"],
        placement: json["placement"],
        joinDate: json["join_date"] == null
            ? null
            : DateTime.parse(json["join_date"]),
        typeAgentId: json["type_agent_id"],
        registerBy: json["register_by"],
        statusActiveId: json["status_active_id"],
        foto: json["foto"] == null
            ? []
            : List<Foto>.from(json["foto"].map((x) => Foto.fromJson(x))),
        signature: json["signature"] == null
            ? []
            : List<Foto>.from(json["signature"].map((x) => Foto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "agent_name": agentName,
        "email": email,
        "alamat": alamat,
        "placement": placement,
        "join_date":
            "${joinDate!.year.toString().padLeft(4, '0')}-${joinDate!.month.toString().padLeft(2, '0')}-${joinDate!.day.toString().padLeft(2, '0')}",
        "type_agent_id": typeAgentId,
        "register_by": registerBy,
        "status_active_id": statusActiveId,
        "foto": foto == null
            ? []
            : List<dynamic>.from(foto!.map((x) => x.toJson())),
        "signature": signature == null
            ? []
            : List<dynamic>.from(signature!.map((x) => x.toJson())),
      };
}

class Foto {
  String? img;

  Foto({
    this.img,
  });

  factory Foto.fromJson(Map<String, dynamic> json) => Foto(
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
      };
}
