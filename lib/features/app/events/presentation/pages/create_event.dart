import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../../../../../core/core.dart';
import '../../events.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _maxAttendees = 50;
  String? _imageUrl;
  bool _isUploading = false;

  late final DateFormat _dateFormat;
  final EventBloc _eventBloc = GetIt.instance<EventBloc>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _dateFormat = DateFormat('''d 'de' MMMM 'de' yyyy''', 'pt_BR');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.gold,
              onPrimary: AppColors.black,
              onSurface: AppColors.white,
            ),
            dialogBackgroundColor: AppColors.darkGray,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _selectedTime.hour,
          _selectedTime.minute,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.gold,
              onPrimary: AppColors.black,
              surface: AppColors.darkGray,
              onSurface: AppColors.white,
            ),
            dialogBackgroundColor: AppColors.darkGray,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        );
      });
    }
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
            .ref('event_images/$fileName')
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

  String _formatDateTime() {
    final date = _dateFormat.format(_selectedDate);
    final time = DateFormat('HH:mm').format(
      DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      ),
    );
    return '$date às $time';
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, adicione uma foto para o evento'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String eventId = DateTime.now().millisecondsSinceEpoch.toString();
    final event = EventModel(
        id: eventId,
        title: _titleController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrl!,
        capacity: _maxAttendees,
        eventDate: _selectedDate.toIso8601String(),
        createdAt: DateTime.now().toIso8601String(),
        location: _locationController.text);

    // Despachar o evento para o bloc
    _eventBloc.add(CreateEvent(event));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Criar Evento',
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
      body: BlocListener<EventBloc, EventState>(
        bloc: _eventBloc,
        listener: (context, state) {
          if (state is EventSuccess) {
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
          } else if (state is EventError) {
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
                    'Informações do Evento',
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
                                            'Adicionar foto do evento',
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
                    controller: _titleController,
                    style: const TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      labelText: 'Título do Evento',
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
                        return 'Por favor, informe o título do evento';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo de descrição
                  TextFormField(
                    controller: _descriptionController,
                    style: const TextStyle(color: AppColors.white),
                    maxLines: 3,
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
                        return 'Por favor, informe a descrição do evento';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo de localização
                  TextFormField(
                    controller: _locationController,
                    style: const TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      labelText: 'Local',
                      prefixIcon: const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.gold,
                      ),
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
                        return 'Por favor, informe o local do evento';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Data e hora
                  const Text(
                    'Data e Hora',
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => _selectDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  color: AppColors.gold,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  _dateFormat.format(_selectedDate),
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () => _selectTime(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                color: AppColors.gold,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
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

                  // Botão de criar evento
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
                              'Criar Evento',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
