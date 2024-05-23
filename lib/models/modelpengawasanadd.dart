
import 'dart:convert';

ModelPengawasanAdd ModelPengawasanAddFromJson(String str) => ModelPengawasanAdd.fromJson(json.decode(str));

String ModelPengawasanAddToJson(ModelPengawasanAdd data) => json.encode(data.toJson());

class ModelPengawasanAdd {
  int value;
  String message;

  ModelPengawasanAdd({
    required this.value,
    required this.message,
  });

  factory ModelPengawasanAdd.fromJson(Map<String, dynamic> json) => ModelPengawasanAdd(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
