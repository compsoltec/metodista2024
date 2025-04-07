import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../module_config/constants/colors_constants.dart';
import '../../../../module_services/service_locator.dart';
import '../../../../module_youtube/components/custom_drawer.dart';
import '../../../modulo_atividade.dart';
import '../../widgets/widgets.dart';

class AtividadeCriacao extends CustomDrawerContent {
  @override
  State<AtividadeCriacao> createState() => _AtividadeCriacaoState();
}

class _AtividadeCriacaoState extends State<AtividadeCriacao> {
  var atividade = getIt.get<AtividadeCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Adicionar Atividade',
          style: GoogleFonts.quicksand(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
          key: atividade.formKey,
          child: Stack(
            children: <Widget>[
              Container(
                color: ColorsConstants().primaryColor,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 700,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    child: FormAtividadeCriacao()),
              ),
            ],
          )),
    );
  }

  // void _showAlert(String message, BuildContext context) {
  //   showCupertinoDialog(
  //       context: context,
  //       builder: (context) {
  //         return CustomDialogBox(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             onPressedLeft: () {
  //               Navigator.pop(context);
  //             },
  //             textLeft: '',
  //             title: 'AoVivo',
  //             descriptions: message,
  //             text: 'Voltar');
  //       });
  // }

  // void onPressedAoVivoLink(BuildContext context) {
  //   final request = AovivoRequestEntity(url: aovivo.controllerUrl.text);
  //   context.read<AovivoCubit>().doAovivo(request);
  // }
}
