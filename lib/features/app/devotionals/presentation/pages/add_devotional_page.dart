import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/devotional.dart';
import '../bloc/devotional_bloc.dart';

class AddDevotionalPage extends StatefulWidget {
  const AddDevotionalPage({super.key});

  @override
  State<AddDevotionalPage> createState() => _AddDevotionalPageState();
}

class _AddDevotionalPageState extends State<AddDevotionalPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController authorCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();
  DateTime? selectedDate;

  XFile? imageFile;
  FilePickerResult? audioFile;

  bool isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => imageFile = pickedFile);
    }
  }

  Future<void> _pickAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    if (result != null) {
      setState(() => audioFile = result);
    }
  }

  Future<String> _uploadFileToFirebase(String path, String folder) async {
    final fileName = path.split('/').last;
    final ref = FirebaseStorage.instance.ref('$folder/$fileName');
    final uploadTask = await ref.putFile(File(path));
    return await uploadTask.ref.getDownloadURL();
  }

  Future<void> _saveDevotional() async {
    if (!_formKey.currentState!.validate() ||
        imageFile == null ||
        audioFile == null ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos e selecione arquivos!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final imageUrl =
          await _uploadFileToFirebase(imageFile!.path, 'devotionals/images');
      final audioUrl = await _uploadFileToFirebase(
          audioFile!.files.single.path!, 'devotionals/audios');

      final devotional = Devotional(
        title: titleCtrl.text,
        author: authorCtrl.text,
        date: DateFormat('yyyy-MM-dd').format(selectedDate!),
        description: descriptionCtrl.text,
        imageUrl: imageUrl,
        audioUrl: audioUrl,
        id: '',
      );

      sl<DevotionalBloc>().add(AddDevotional(devotional));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Devocional adicionado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erro ao salvar: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.copper,
              onPrimary: AppColors.white,
              surface: AppColors.darkPurple,
              onSurface: AppColors.white,
            ),
            dialogBackgroundColor: AppColors.darkPurple,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Adicionar Devocional',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildInputField(titleCtrl, 'Título'),
              const SizedBox(height: 16),
              _buildInputField(authorCtrl, 'Autor'),
              const SizedBox(height: 16),
              _buildInputField(descriptionCtrl, 'Descrição', maxLines: 3),
              const SizedBox(height: 16),
              _buildSelectionTile(
                label: selectedDate == null
                    ? 'Selecionar Data'
                    : DateFormat('dd/MM/yyyy').format(selectedDate!),
                icon: Icons.calendar_today,
                onTap: _selectDate,
              ),
              const SizedBox(height: 16),
              _buildSelectionTile(
                label: imageFile == null
                    ? 'Selecionar Imagem'
                    : 'Imagem Selecionada',
                icon: Icons.image,
                onTap: _pickImage,
              ),
              const SizedBox(height: 16),
              _buildSelectionTile(
                label: audioFile == null
                    ? 'Selecionar Áudio'
                    : 'Áudio Selecionado',
                icon: Icons.audiotrack,
                onTap: _pickAudio,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _saveDevotional,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.copper,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: AppColors.white)
                      : const Text(
                          'Salvar Devocional',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: AppColors.white),
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.white.withOpacity(0.7)),
        filled: true,
        fillColor: AppColors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Por favor, informe $label' : null,
    );
  }

  Widget _buildSelectionTile(
      {required String label,
      required IconData icon,
      required VoidCallback onTap}) {
    return ListTile(
      tileColor: AppColors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(label, style: const TextStyle(color: AppColors.white)),
      trailing: Icon(icon, color: AppColors.copper),
      onTap: onTap,
    );
  }
}
