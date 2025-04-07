import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../modulo_common_services/modulo_common_services.dart';
import '../controller/acesso_controller.dart';

class SolicitarAcesso extends StatelessWidget {
  final AcessoController controller = Get.put(AcessoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 3,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32.0)),
                            child: Material(
                              shadowColor: Colors.transparent,
                              color: Colors.transparent,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 3,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Solicitar Acesso',
                              style: GoogleFonts.quicksand(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      _buildTextField(
                        maxLines: 1,
                        label: 'Nome Completo',
                        controller: controller.nomeController,
                        validator: (value) => controller.validarCampoVazio(
                            value, 'Nome Completo'),
                      ),
                      SizedBox(),
                      _buildTextField(
                        maxLines: 4,
                        label: 'Descrição do Acesso',
                        controller: controller.descricaoController,
                        validator: (value) => controller.validarCampoVazio(
                            value, 'Nome Completo'),
                      ),
                      Center(
                        child: Obx(() => SizedBox(
                              width: Get.size.width * 1.0,
                              height: Get.size.height * 0.07,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      ColorsConstants().primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: controller.isLoading.value
                                    ? null
                                    : controller.solicitarAcesso,
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : Text('Solicitar Acesso',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white)),
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    required int maxLines,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 14)),
          SizedBox(height: 8),
          TextFormField(
            maxLines: maxLines,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
