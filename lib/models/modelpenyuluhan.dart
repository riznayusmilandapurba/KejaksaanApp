// To parse this JSON data, do
//
//     final modelkonten = modelkontenFromJson(jsonString);

import 'dart:convert';

ModelPenyuluhan ModelPenyuluhanFromJson(String str) => ModelPenyuluhan.fromJson(json.decode(str));

String ModelPenyuluhanToJson(ModelPenyuluhan data) => json.encode(data.toJson());

class ModelPenyuluhan {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelPenyuluhan({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelPenyuluhan.fromJson(Map<String, dynamic> json) => ModelPenyuluhan(
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
  String nama;
  String nohp;
  String ktp;
  String permasalahan;
  String status;

  Datum({
    required this.id,
    required this.nama,
    required this.nohp,
    required this.ktp,
    required this.permasalahan,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nama: json["nama"],
    nohp: json["nohp"],
    ktp: json["ktp"],
    permasalahan: json["permasalahan"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "nohp": nohp,
    "ktp": ktp,
    "permasalahan": permasalahan,
    "status": status,
  };
}
