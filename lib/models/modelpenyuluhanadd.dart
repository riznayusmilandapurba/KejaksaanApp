
import 'dart:convert';

ModelPenyuluhanAdd ModelPenyuluhanAddFromJson(String str) => ModelPenyuluhanAdd.fromJson(json.decode(str));

String ModelPenyuluhanAddToJson(ModelPenyuluhanAdd data) => json.encode(data.toJson());

class ModelPenyuluhanAdd {
  int value;
  String message;

  ModelPenyuluhanAdd({
    required this.value,
    required this.message,
  });

  factory ModelPenyuluhanAdd.fromJson(Map<String, dynamic> json) => ModelPenyuluhanAdd(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
