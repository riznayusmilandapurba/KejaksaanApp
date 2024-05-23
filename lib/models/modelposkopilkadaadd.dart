
import 'dart:convert';

ModelPoskoPilkadaAdd ModelPoskoPilkadaAddFromJson(String str) => ModelPoskoPilkadaAdd.fromJson(json.decode(str));

String ModelPoskoPilkadaAddToJson(ModelPoskoPilkadaAdd data) => json.encode(data.toJson());

class ModelPoskoPilkadaAdd {
  int value;
  String message;

  ModelPoskoPilkadaAdd({
    required this.value,
    required this.message,
  });

  factory ModelPoskoPilkadaAdd.fromJson(Map<String, dynamic> json) => ModelPoskoPilkadaAdd(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
