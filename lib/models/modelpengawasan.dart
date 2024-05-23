// To parse this JSON data, do
//
//     final modelkonten = modelkontenFromJson(jsonString);

import 'dart:convert';

ModelPengawasan ModelPengawasanFromJson(String str) => ModelPengawasan.fromJson(json.decode(str));

String ModelPengawasanToJson(ModelPengawasan data) => json.encode(data.toJson());

class ModelPengawasan {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelPengawasan({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelPengawasan.fromJson(Map<String, dynamic> json) => ModelPengawasan(
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
  String laporan;
  String status;

  Datum({
    required this.id,
    required this.namapelapor,
    required this.nohp,
    required this.ktp,
    required this.laporan,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    namapelapor: json["namapelapor"],
    nohp: json["nohp"],
    ktp: json["ktp"],
    laporan: json["laporan"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "namapelapor": namapelapor,
    "nohp": nohp,
    "ktp": ktp,
    "laporan": laporan,
    "status": status,
  };
}
