import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metodista/module_ministerios/ministerios/controllers/escalas_controllers.dart';

class CircularDropdownButton extends StatefulWidget {
  @override
  _CircularDropdownButtonState createState() => _CircularDropdownButtonState();
}

class _CircularDropdownButtonState extends State<CircularDropdownButton> {
  String _selectedItem = 'Oração';
  final escalaController = Get.put(EscalasController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: Get.size.height * 0.08,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(20.0), // Define as bordas circulares
          border: Border.all(
              color: Colors.grey), // Adiciona uma borda ao redor do botão
        ),
        child: DropdownButton<String>(
          isExpanded: true,
          alignment: Alignment.bottomCenter,
          underline: SizedBox(
            height: 1,
          ),
          value: _selectedItem,
          onChanged: (String? newValue) {
            setState(() {
              _selectedItem = newValue!;
              escalaController.ministerio = newValue;
            });
          },
          items: <String>['Oração', 'Crianças', 'Louvor', 'Acolhida']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0), // Espaçamento interno para o texto
                child: Text(
                  value,
                  style: GoogleFonts.quicksand(),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
