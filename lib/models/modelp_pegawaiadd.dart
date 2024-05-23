
import 'dart:convert';

ModelPPegawaiAdd ModelPPegawaiAddFromJson(String str) => ModelPPegawaiAdd.fromJson(json.decode(str));

String ModelPPegawaiAddToJson(ModelPPegawaiAdd data) => json.encode(data.toJson());

class ModelPPegawaiAdd {
  int value;
  String message;

  ModelPPegawaiAdd({
    required this.value,
    required this.message,
  });

  factory ModelPPegawaiAdd.fromJson(Map<String, dynamic> json) => ModelPPegawaiAdd(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
