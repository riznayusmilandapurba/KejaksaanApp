
import 'dart:convert';

ModelJMSAdd ModelJMSAddFromJson(String str) => ModelJMSAdd.fromJson(json.decode(str));

String ModelJMSAddToJson(ModelJMSAdd data) => json.encode(data.toJson());

class ModelJMSAdd {
  int value;
  String message;

  ModelJMSAdd({
    required this.value,
    required this.message,
  });

  factory ModelJMSAdd.fromJson(Map<String, dynamic> json) => ModelJMSAdd(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
