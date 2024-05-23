// To parse this JSON data, do
//
//     final modellogin = modelloginFromJson(jsonString);

import 'dart:convert';

Modellogin modelloginFromJson(String str) => Modellogin.fromJson(json.decode(str));

String modelloginToJson(Modellogin data) => json.encode(data.toJson());

class Modellogin {
    int value;
    String message;
    String nama;
    String email;
    String phone;
    String ktp;
    String alamat;
    int id;
    String role;

    Modellogin({
        required this.value,
        required this.message,
        required this.nama,
        required this.email,
        required this.phone,
        required this.ktp,
        required this.alamat,
        required this.id,
        required this.role,
    });

    factory Modellogin.fromJson(Map<String, dynamic> json) => Modellogin(
        value: json["value"],
        message: json["message"],
        nama: json["nama"],
        email: json["email"],
        phone: json["phone"],
        ktp: json["ktp"],
        alamat: json["alamat"],
        id: json["id"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "nama": nama,
        "email": email,
        "phone": phone,
        "ktp": ktp,
        "alamat": alamat,
        "id": id,
        "role": role,
    };
}
