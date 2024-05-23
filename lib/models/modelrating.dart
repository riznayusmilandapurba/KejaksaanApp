
import 'dart:convert';

ModelRating ModelRatingFromJson(String str) => ModelRating.fromJson(json.decode(str));

String ModelRatingToJson(ModelRating data) => json.encode(data.toJson());

class ModelRating {
  int value;
  String message;

  ModelRating({
    required this.value,
    required this.message,
  });

  factory ModelRating.fromJson(Map<String, dynamic> json) => ModelRating(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
