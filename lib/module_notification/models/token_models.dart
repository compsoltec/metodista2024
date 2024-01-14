import 'dart:convert';

List<TokenModels> tokenFromJson(str) =>
    List<TokenModels>.from(str.map((x) => TokenModels.fromJson(x)));

String tokenModelsToJson(TokenModels data) => json.encode(data.toJson());

class TokenModels {
  String id;

  TokenModels({
    required this.id,
  });

  factory TokenModels.fromJson(Map<String, dynamic> json) => TokenModels(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
