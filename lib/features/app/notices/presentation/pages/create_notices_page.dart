import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../../../../../core/core.dart';
import '../../notices.dart';

class CreateNoticesScreen extends StatefulWidget {
  const CreateNoticesScreen({super.key});

  @override
  State<CreateNoticesScreen> createState() => _CreateNoticesScreenState();
}

class _CreateNoticesScreenState extends State<CreateNoticesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  XFile? _videoFile;
  VideoPlayerController? _videoController;
  String? _imageUrl;
  bool _isUploading = false;
  final NoticesBloc _noticesBloc = GetIt.instance<NoticesBloc>();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    try {
      setState(() => _isUploading = true);

      final picker = ImagePicker();
      final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);

      if (pickedVideo != null) {
        final bytes = await pickedVideo.readAsBytes();
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${path.basename(pickedVideo.path)}';

        final task = FirebaseStorage.instance
            .ref('cells_videos/$fileName')
            .putData(bytes);

        final snapshot = await task;
        final videoUrl = await snapshot.ref.getDownloadURL();

        _videoController?.dispose();
        _videoController = VideoPlayerController.network(videoUrl)
          ..initialize().then((_) => setState(() {}));

        setState(() {
          _videoFile = pickedVideo;
          _imageUrl = videoUrl;
          _isUploading = false;
        });
      } else {
        setState(() => _isUploading = false);
      }
    } catch (e) {
      setState(() => _isUploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar vídeo: ${e.toString()}'),
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
          content: Text('Por favor, adicione um video'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String courcesId = DateTime.now().millisecondsSinceEpoch.toString();

    final notices = Notices(
      id: courcesId,
      image: _imageUrl!,
      name: _titleController.text,
      description: _descriptionController.text,
    );

    // Despachar o courceso para o bloc
    _noticesBloc.add(CreateNotices(notices));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Adicionar Célula',
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
      body: BlocListener<NoticesBloc, NoticesState>(
        bloc: _noticesBloc,
        listener: (context, state) {
          if (state is NoticesSuccess) {
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
          } else if (state is NoticesError) {
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
                    'Informações do Aviso',
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
                          onTap: _isUploading ? null : _pickVideo,
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: _isUploading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.gold),
                                    ),
                                  )
                                : _videoController != null &&
                                        _videoController!.value.isInitialized
                                    ? Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: _videoController!
                                                .value.aspectRatio,
                                            child:
                                                VideoPlayer(_videoController!),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: CircleAvatar(
                                              backgroundColor: AppColors.black
                                                  .withOpacity(0.7),
                                              radius: 18,
                                              child: IconButton(
                                                icon: const Icon(Icons.edit,
                                                    color: AppColors.gold,
                                                    size: 18),
                                                onPressed: _pickVideo,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.video_library,
                                              color: AppColors.gold, size: 50),
                                          SizedBox(height: 8),
                                          Text(
                                            'Adicionar vídeo',
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                          ),
                        ),
                        if (_videoFile != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Vídeo carregado com sucesso',
                              style: TextStyle(
                                  color: Colors.green[400], fontSize: 14),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Campo de título
                  TextFormField(
                    controller: _titleController,
                    style: const TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      labelText: 'Título do Vídeo',
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
                        return 'Por favor, informe o título do vídeo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
// Campo de descrição
                  TextFormField(
                    maxLines: 5,
                    controller: _descriptionController,
                    style: const TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      labelText: 'Descrição',
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
                        return 'Por favor, informe uma descrição para o aviso';
                      }
                      return null;
                    },
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
                              'Salvar Aviso',
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
