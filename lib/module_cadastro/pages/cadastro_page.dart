import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metodista/module_config/constants/colors_constants.dart';
import '../../app_properties.dart';
import '../../module_youtube/components/custom_drawer.dart';
import '../controllers/cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final CadastroController controller = Get.put(CadastroController());

  final List<String> statusProfissionalList = [
    'Empresário',
    'Autônomo',
    'Empregado do setor privado',
    'Empregado do setor público',
    'Procurando emprego'
  ];

  final List<String> areaAtuacaoList = [
    'Acupunturista',
    'Administrador',
    'Administrativo',
    'Advogado',
    'Agrônomo',
    'Analista de marketing',
    'Analista de segurança da informação',
    'Analista de sistemas',
    'Analista de suporte técnico',
    'Analista financeiro',
    'Apicultor',
    'Arquiteto',
    'Arquiteto de soluções',
    'Assistente administrativo',
    'Assistente social',
    'Astrônomo',
    'Atendimento ao cliente',
    'Ator',
    'Auditor',
    'Auxiliar de enfermagem',
    'Biólogo',
    'Barbeiro',
    'Bombeiro',
    'Cabeleireiro',
    'Camareira',
    'Cantor',
    'Carpinteiro',
    'Cenógrafo',
    'Cientista de dados',
    'Comissário de bordo',
    'Contabilidade',
    'Contador',
    'Controlador de tráfego aéreo',
    'Coordenador pedagógico',
    'Corretor de seguros',
    'Cozinheiro',
    'Defensor público',
    'Delegado de polícia',
    'Dentista',
    'Desenvolvedor de software',
    'Designer gráfico',
    'Diretor de cinema',
    'Diretor de escola',
    'Economista',
    'Editor de vídeos',
    'Educador social',
    'Eletricista',
    'Encanador',
    'Enfermeiro',
    'Engenheiro ambiental',
    'Engenheiro civil',
    'Engenheiro de produção',
    'Engenheiro elétrico',
    'Engenheiro mecânico',
    'Engenheiro químico',
    'Escrivão',
    'Estatístico',
    'Esteticista',
    'Farmacêutico',
    'Fabricação',
    'Físico',
    'Fisioterapeuta',
    'Floricultor',
    'Fonoaudiólogo',
    'Fotógrafo',
    'Garçom',
    'Geólogo',
    'Gerente de projetos de TI',
    'Gerente de vendas',
    'Gestor de recursos humanos',
    'Guarda municipal',
    'Ilustrador',
    'Instrutor de cursos',
    'Internacional',
    'Investigador',
    'Jornalista',
    'Juiz',
    'Jurídico',
    'Logístico',
    'Manicure',
    'Marketing',
    'Médico',
    'Mediador de conflitos',
    'Mestre de obras',
    'Monitor',
    'Motorista',
    'Motorista de ônibus',
    'Músico',
    'Nutricionista',
    'Oceanógrafo',
    'Oficial de justiça',
    'Operador de empilhadeira',
    'Operações',
    'Orientador educacional',
    'Outro (especifique)',
    'Paramedico',
    'Pedagogo',
    'Pedreiro',
    'Pesquisador',
    'Pintor',
    'Piloto de avião',
    'Policial',
    'Politólogo',
    'Porteiro',
    'Produtor de conteúdo digital',
    'Produtor musical',
    'Produtor rural',
    'Produto',
    'Professor',
    'Programador',
    'Promotor de justiça',
    'Psicólogo',
    'Psicólogo social',
    'Psicopedagogo',
    'Publicitário',
    'Radialista',
    'Recepcionista',
    'Redator',
    'Recursos humanos',
    'Relações Públicas',
    'Repórter',
    'Secretário executivo',
    'Segurança',
    'Silvicultor',
    'Social media',
    'Soldado',
    'Sociólogo',
    'Técnico agrícola',
    'Técnico em edificações',
    'Técnico em radiologia',
    'Terapeuta ocupacional',
    'TI',
    'Vendas',
    'Veterinário',
    'Web designer',
    'Zelador',
    'Zootecnista'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
      ),
      body: SafeArea(
        child: SizedBox(
          height: Get.size.height * 1.0,
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        // Nome Completo
                        _buildTextField(
                          maxLines: 1,
                          label: 'Nome Completo',
                          controller: controller.nomeController,
                          validator: (value) => controller.validarCampoVazio(
                              value, 'Nome Completo'),
                        ),
                        // Data de Nascimento
                        _buildTextField(
                          maxLines: 1,
                          inputFormatters: [controller.maskDataNascimento],
                          label: 'Data de Nascimento (Formato dd/mm/aa)',
                          controller: controller.dataNascimentoController,
                          keyboardType: TextInputType.datetime,
                          validator: controller.validarDataNascimento,
                        ),
                        // Celular
                        _buildTextField(
                          maxLines: 1,
                          inputFormatters: [controller.maskTelefone],
                          label: 'Celular',
                          controller: controller.celular,
                          validator: (value) =>
                              controller.validarCampoVazio(value, 'Celular'),
                        ),
                        // Status Profissional
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text('Status Profissional',
                              style: GoogleFonts.poppins(fontSize: 16)),
                        ),
                        Obx(() => DropdownButtonFormField<String>(
                              value: controller.statusProfissional.value.isEmpty
                                  ? null
                                  : controller.statusProfissional.value,
                              hint: Text('Selecione um status profissional',
                                  style: GoogleFonts.poppins()),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onChanged: (value) {
                                controller.statusProfissional.value =
                                    value ?? '';
                              },
                              items: statusProfissionalList
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e,
                                            style: GoogleFonts.poppins()),
                                      ))
                                  .toList(),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Status Profissional é obrigatório.'
                                      : null,
                            )),
                        // Área de Atuação
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text('Área de Atuação',
                              style: GoogleFonts.poppins(fontSize: 16)),
                        ),
                        Obx(() => DropdownButtonFormField<String>(
                              value: controller.areaAtuacao.value.isEmpty
                                  ? null
                                  : controller.areaAtuacao.value,
                              hint: Text('Selecione uma área',
                                  style: GoogleFonts.poppins()),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onChanged: (value) {
                                controller.areaAtuacao.value = value ?? '';
                                print(value);
                              },
                              items: areaAtuacaoList
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e,
                                            style: GoogleFonts.poppins()),
                                      ))
                                  .toList(),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Área de Atuação é obrigatória.'
                                      : null,
                            )),
                        // Botão Cadastrar
                        SizedBox(height: 24),
                        Obx(() => controller.areaAtuacao.value
                                .contains('Outro (especifique)')
                            ? _buildTextField(
                                maxLines: 5,
                                label: 'Descrição',
                                controller: controller.descricao,
                              )
                            : SizedBox()),
                        SizedBox(height: 24),

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
                                      : controller.cadastrarUsuario,
                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.white)
                                      : Text('Cadastrar',
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
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required int maxLines,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
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
            inputFormatters: inputFormatters,
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
