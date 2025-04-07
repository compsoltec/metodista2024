import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:metodista/module_common_deps/module_common_deps.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../../../../module_config/constants/colors_constants.dart';
import '../../../../module_designer_system/components/custom_alert_dialog.dart';
import '../../../../module_designer_system/components/custom_textField.dart';
import '../../../../module_designer_system/components/custom_textFormField.dart';
import '../../../../module_designer_system/components/cutom_button.dart';
import '../../../../module_services/service_locator.dart';
import '../../../modulo_atividade.dart';
import '../../cubit/atividade_cubit.dart';

class FormAtividadeCriacao extends StatefulWidget {
  const FormAtividadeCriacao({super.key});

  @override
  State<FormAtividadeCriacao> createState() => _FormAtividadeCriacaoState();
}

class _FormAtividadeCriacaoState extends State<FormAtividadeCriacao> {
  var atividade = getIt.get<AtividadeCubit>();

  FirebaseStorage storage = FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();
  bool loading = false;
  var maskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: _photo != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      _photo!,
                      width: 400,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            labelText: 'Título',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'O campo Título não pode estar vázio';
              }
              return null;
            },
            obscureText: false,
            controller: atividade.cnotrollerTitulo),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          controller: atividade.controllerData,
          borderColor: ColorsConstants().primaryColor,
          label: 'Data',
          textInputType: TextInputType.number,
          inputFormatters: [maskFormatter],
          hintText: '',
          labelColor: Colors.black,
          validators: (value) {
            if (value == null || value.isEmpty) {
              return 'O campo Data não pode estar vázio';
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            labelText: 'Descrição',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'O campo Descrição não pode estar vázio';
              }
              return null;
            },
            obscureText: false,
            controller: atividade.controllerDescricao),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            labelText: 'Vagas',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'O campo Vagas não pode estar vázio';
              }
              return null;
            },
            obscureText: false,
            controller: atividade.controllerVaga),
        const SizedBox(
          height: 10,
        ),
        BlocConsumer<AtividadeCubit, AtividadeState>(builder: (context, state) {
          final bool isLoadingState = state is AtividadeLoadingState;
          return CustomButton(
              showProgress: isLoadingState,
              textColor: Colors.white,
              text: 'Salvar Atividade',
              onPressed: () {
                onPressedDevocional(context);
              },
              color: ColorsConstants().primaryColor);
        }, listener: (context, state) {
          if (state is AtividadeSuccessState) {
            atividade.controllerData.clear();
            atividade.controllerDescricao.clear();
            atividade.controllerVaga.clear();
            atividade.cnotrollerTitulo.clear();
            atividade.urlDownload == null;
            _showAlert('Atividade Salva com Sucesso', context);
          }
        })
      ],
    );
  }

  void _showAlert(String message, BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox(
              onPressed: () {
                Navigator.pop(context);
              },
              onPressedLeft: () {
                Navigator.pop(context);
              },
              textLeft: '',
              title: 'Atividade',
              descriptions: message,
              text: 'Voltar');
        });
  }

  void onPressedDevocional(BuildContext context) {
    int vagas = int.parse(atividade.controllerVaga.text);
    final request = AtividadeRequestEntity(
      inscritos: [],
      titulo: atividade.cnotrollerTitulo.text,
      data: atividade.controllerData.text,
      descricao: atividade.controllerDescricao.text,
      foto: 'djaodjaoda'!,
      vagas: vagas,
    );
    context.read<AtividadeCubit>().doAtividade(request);
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(_photo!);
      final urlDownload = await ref.getDownloadURL();
      atividade.urlDownload = urlDownload;
      print(urlDownload);
    } catch (e) {
      print('error occured');
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
