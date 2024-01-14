import 'dart:convert';

List<LoginModels> loginFromJson(str) =>
    List<LoginModels>.from(str.map((x) => LoginModels.fromJson(x)));
String loginModelsToJson(LoginModels data) => json.encode(data.toJson());

class LoginModels {
  String email;
  String senha;

  LoginModels({
    required this.email,
    required this.senha,
  });

  factory LoginModels.fromJson(Map<String, dynamic> json) => LoginModels(
        email: json["email"],
        senha: json["senha"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "senha": senha,
      };
}
