// To parse this JSON data, do
//
//     final modelkonten = modelkontenFromJson(jsonString);

import 'dart:convert';

ModelJMS ModelJMSFromJson(String str) => ModelJMS.fromJson(json.decode(str));

String ModelJMSToJson(ModelJMS data) => json.encode(data.toJson());

class ModelJMS {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelJMS({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelJMS.fromJson(Map<String, dynamic> json) => ModelJMS(
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
  String namasekolah;
  String namapemohon;
  String status;

  Datum({
    required this.id,
    required this.namasekolah,
    required this.namapemohon,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    namasekolah: json["namasekolah"],
    namapemohon: json["namapemohon"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "namasekolah": namasekolah,
    "namapemohon": namapemohon,
    "status": status,
  };
}
