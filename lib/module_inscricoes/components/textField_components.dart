import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification2/module_inscricoes/controllers/inscricoes_controllers.dart';

class TextFieldComponents extends StatelessWidget {
  final inscritosController = Get.put(InscricoesController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.16,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1.0, color: Colors.grey.shade300)),
      child: TextFormField(
        controller: inscritosController.controllerNome,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 14),
          hintText: 'Insira seu nome',
          icon: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(Icons.person),
          ),
        ),
      ),
    );
  }
}
