
import 'dart:convert';

ModelTindakKorupsiAdd ModelTindakKorupsiAddFromJson(String str) => ModelTindakKorupsiAdd.fromJson(json.decode(str));

String ModelTindakKorupsiAddToJson(ModelTindakKorupsiAdd data) => json.encode(data.toJson());

class ModelTindakKorupsiAdd {
  int value;
  String message;

  ModelTindakKorupsiAdd({
    required this.value,
    required this.message,
  });

  factory ModelTindakKorupsiAdd.fromJson(Map<String, dynamic> json) => ModelTindakKorupsiAdd(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
