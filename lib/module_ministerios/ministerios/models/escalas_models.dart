class EscalasModels {
  late String ministerio;
  late String data;
  late List<String> integrantes;

  EscalasModels(
      {required this.ministerio,
      required this.data,
      required this.integrantes});

  EscalasModels.fromJson(Map<String, dynamic> json) {
    ministerio = json['ministerio'];
    data = json['data'];
    integrantes = json['integrantes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ministerio'] = this.ministerio;
    data['data'] = this.data;
    data['integrantes'] = this.integrantes;
    return data;
  }
}
