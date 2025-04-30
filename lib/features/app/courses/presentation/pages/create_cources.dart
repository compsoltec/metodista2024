import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../../../../../core/core.dart';
import '../../cources.dart';

class CreateCourcesScreen extends StatefulWidget {
  const CreateCourcesScreen({super.key});

  @override
  State<CreateCourcesScreen> createState() => _CreateCourcesScreenState();
}

class _CreateCourcesScreenState extends State<CreateCourcesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _requiresRegistration = false;
  String? _imageUrl;
  bool _isUploading = false;
  final CourcesBloc _courcesBloc = GetIt.instance<CourcesBloc>();
  bool _isLoading = false;
  int _maxAttendees = 50;

  @override
  void dispose() {
    _nameController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      setState(() {
        _isUploading = true;
      });

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (image != null) {
        // Aqui você implementaria a lógica para fazer o upload da imagem
        // e obter a URL. Abaixo é um exemplo simples:

        // 1. Convertendo o arquivo para bytes
        final fileBytes = await image.readAsBytes();
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${path.basename(image.path)}';

        // 2. Fazendo upload para o seu serviço de armazenamento
        // Este é um exemplo fictício - você precisará implementar a lógica real
        // de acordo com o serviço que está usando (Firebase Storage, Amazon S3, etc.)
        final uploadTask = FirebaseStorage.instance
            .ref('cources_images/$fileName')
            .putData(fileBytes);

        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          _imageUrl = downloadUrl;
          _isUploading = false;
        });
      } else {
        setState(() {
          _isUploading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar imagem: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, adicione uma foto para o courceso'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String courcesId = DateTime.now().millisecondsSinceEpoch.toString();

    final cources = Cources(
        id: courcesId,
        image: _imageUrl!,
        name: _nameController.text,
        course: _courseController.text,
        inscricoes: _requiresRegistration,
        phone: _phoneController.text,
        capacity: _maxAttendees);

    // Despachar o courceso para o bloc
    _courcesBloc.add(CreateCources(cources));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Criar Courceso',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocListener<CourcesBloc, CourcesState>(
        bloc: _courcesBloc,
        listener: (context, state) {
          if (state is CourcesSuccess) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          } else if (state is CourcesError) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  const Text(
                    'Informações do Curso',
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Adicionar imagem
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _isUploading ? null : _pickImage,
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.white.withOpacity(0.2),
                                width: 1,
                              ),
                              image: _imageUrl != null
                                  ? DecorationImage(
                                      image: NetworkImage(_imageUrl!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: _isUploading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.gold),
                                    ),
                                  )
                                : _imageUrl == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.add_photo_alternate_outlined,
                                            color: AppColors.gold,
                                            size: 50,
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Adicionar foto do curso',
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        alignment: Alignment.topRight,
                                        padding: const EdgeInsets.all(8),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColors.black.withOpacity(0.7),
                                          radius: 18,
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              color: AppColors.gold,
                                              size: 18,
                                            ),
                                            onPressed: _pickImage,
                                          ),
                                        ),
                                      ),
                          ),
                        ),
                        if (_imageUrl != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Foto carregada com sucesso',
                              style: TextStyle(
                                color: Colors.green[400],
                                fontSize: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Campo de título
                  TextFormField(
                    controller: _nameController,
                    style: const TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      labelText: 'Nome do Responsável',
                      labelStyle:
                          TextStyle(color: AppColors.white.withOpacity(0.7)),
                      filled: true,
                      fillColor: AppColors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.gold,
                          width: 1,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, informe o responsável do curso';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                      labelStyle:
                          TextStyle(color: AppColors.white.withOpacity(0.7)),
                      filled: true,
                      fillColor: AppColors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.gold,
                          width: 1,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, informe o telefone do responsável do curso';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo de descrição
                  TextFormField(
                    controller: _courseController,
                    style: const TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      labelText: 'Nome do Curso',
                      labelStyle:
                          TextStyle(color: AppColors.white.withOpacity(0.7)),
                      filled: true,
                      fillColor: AppColors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.gold,
                          width: 1,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, informe o nonme do curso';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Precisa de Inscrição?',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Switch(
                        value: _requiresRegistration,
                        activeColor: AppColors.gold,
                        onChanged: (value) {
                          setState(() {
                            _requiresRegistration = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Número máximo de participantes
                  const Text(
                    'Capacidade',
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'Número máximo de participantes',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    value: _maxAttendees.toDouble(),
                    min: 10,
                    max: 500,
                    divisions: 49,
                    activeColor: AppColors.gold,
                    inactiveColor: AppColors.white.withOpacity(0.2),
                    label: _maxAttendees.toString(),
                    onChanged: (value) {
                      setState(() {
                        _maxAttendees = value.round();
                      });
                    },
                  ),

                  Center(
                    child: Text(
                      '$_maxAttendees pessoas',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Botão de criar courceso
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.white),
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Criar Curso',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
