import 'dart:convert';

List<AgendaTemploModel> agendaTemplosFromJson(str) =>
    List<AgendaTemploModel>.from(str.map((x) => AgendaTemploModel.fromJson(x)));

String temploModelsToJson(List<AgendaTemploModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AgendaTemploModel {
  String data;
  List<Horario> horario;
  String dataTime;

  AgendaTemploModel(
      {required this.data, required this.horario, required this.dataTime});

  factory AgendaTemploModel.fromJson(Map<String, dynamic> json) =>
      AgendaTemploModel(
        data: json["data"],
        dataTime: json['dataTime'],
        horario:
            List<Horario>.from(json["horario"].map((x) => Horario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "dataTime": dataTime,
        "horario": List<dynamic>.from(horario.map((x) => x.toJson())),
      };
}

class Horario {
  String evento;
  String hora;
  String local;

  Horario({
    required this.evento,
    required this.hora,
    required this.local,
  });

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        evento: json["evento"],
        hora: json["hora"],
        local: json["local"],
      );

  Map<String, dynamic> toJson() => {
        "evento": evento,
        "hora": hora,
        "local": local,
      };
}
