// To parse this JSON data, do
//
//     final modelkonten = modelkontenFromJson(jsonString);

import 'dart:convert';

ModelTindakkorupsi ModelTindakkorupsiFromJson(String str) => ModelTindakkorupsi.fromJson(json.decode(str));

String ModelTindakkorupsiToJson(ModelTindakkorupsi data) => json.encode(data.toJson());

class ModelTindakkorupsi {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelTindakkorupsi({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelTindakkorupsi.fromJson(Map<String, dynamic> json) => ModelTindakkorupsi(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String namapelapor;
  String nohp;
  String ktp;
  String uraian;
  String laporan;
  String status;

  Datum({
    required this.id,
    required this.namapelapor,
    required this.nohp,
    required this.ktp,
    required this.uraian,
    required this.laporan,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    namapelapor: json["namapelapor"],
    nohp: json["nohp"],
    ktp: json["ktp"],
    uraian: json["uraian"],
    laporan: json["laporan"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "namapelapor": namapelapor,
    "nohp": nohp,
    "ktp": ktp,
    "uraian": uraian,
    "laporan": laporan,
    "status": status,
  };
}
