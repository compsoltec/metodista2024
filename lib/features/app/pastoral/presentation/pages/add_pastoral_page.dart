import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../bloc/bloc.dart';

class AddPastoralPage extends StatefulWidget {
  const AddPastoralPage({super.key});

  @override
  State<AddPastoralPage> createState() => _AddPastoralPageState();
}

class _AddPastoralPageState extends State<AddPastoralPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  DateTime? _selectedDate;
  List<File> _selectedImages = [];

  bool _isLoading = false;

  Future<void> _pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages = pickedFiles.map((e) => File(e.path)).toList();
      });
    }
  }

  Future<List<String>> _uploadImages(List<File> images) async {
    List<String> urls = [];
    for (var image in images) {
      final fileName =
          'pastorals/${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}';
      final ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }

  void _savePastoral() async {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedImages.isNotEmpty) {
      setState(() => _isLoading = true);

      final imageUrls = await _uploadImages(_selectedImages);

      context.read<PastoralBloc>().add(
            CreatePastoralEvent(
              title: _titleController.text,
              text: _textController.text,
              author: _authorController.text,
              date: _selectedDate!,
              imageUrls: imageUrls,
            ),
          );

      // ❌ Remova este Get.back();
      // Get.back();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Preencha todos os campos e selecione ao menos uma imagem!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:
            const Text('Nova Pastoral', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<PastoralBloc, PastoralState>(
          builder: (BuildContext context, state) {
            if (state is PastoralSuccess) {
              if (state is PastoralLoading) {
                return const Center(
                    child: CircularProgressIndicator(color: AppColors.gold));
              }
              setState(() => _isLoading = false); // Libera o loading
              Get.back();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is PastoralError) {
              setState(() => _isLoading = false); // Libera o loading
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(_titleController, 'Título'),
                  const SizedBox(height: 20),
                  _buildTextField(_authorController, 'Autor'),
                  const SizedBox(height: 20),
                  _buildTextField(_textController, 'Texto',
                      maxLines: 5, isTextArea: true),
                  const SizedBox(height: 20),
                  ListTile(
                    title: Text(
                      _selectedDate == null
                          ? 'Selecionar Data'
                          : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing:
                        const Icon(Icons.calendar_today, color: AppColors.gold),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.gold),
                      ),
                      child: _selectedImages.isEmpty
                          ? const Center(
                              child: Text('Selecionar Imagens',
                                  style: TextStyle(color: Colors.white70)),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _selectedImages.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          _selectedImages[index],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedImages.removeAt(index);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: _savePastoral,
                    child: const Text('Salvar',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1, bool isTextArea = false}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.gold)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.gold)),
      ),
      validator: (value) =>
          value!.isEmpty ? 'Por favor, informe o $label' : null,
    );
  }
}
