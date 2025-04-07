import 'dart:convert';

List<TokenModels> tokenFromJson(str) =>
    List<TokenModels>.from(str.map((x) => TokenModels.fromJson(x)));

String tokenModelsToJson(TokenModels data) => json.encode(data.toJson());

class TokenModels {
  String uuid;
  String token;

  TokenModels({
    required this.uuid,
    required this.token,
  });

  factory TokenModels.fromJson(Map<String, dynamic> json) => TokenModels(
        uuid: json["uuid"],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {"uuid": uuid, "token": token};
}
