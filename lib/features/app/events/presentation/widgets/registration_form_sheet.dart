import 'package:flutter/material.dart';
import 'package:metodista/features/app/events/domain/domain.dart';

import '../../../../../core/core.dart';

class RegistrationForm extends StatefulWidget {
  final EventRepository repository;
  final String eventId;

  const RegistrationForm({
    super.key,
    required this.repository,
    required this.eventId,
  });

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _churchController = TextEditingController();
  bool _isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final fcmToken = await FirebaseMessaging.instance.getToken();
    final createdAt = DateTime.now().toIso8601String();
    final phone = ""; // Você pode capturar o telefone do usuário, se necessário

    final result = await widget.repository.registerForEvent(
      widget.eventId,
      Registration(
        id: '',
        eventId: widget.eventId,
        name: _nameController.text.trim(),
        age: int.parse(_ageController.text),
        church: _churchController.text.trim(),
        createdAt: createdAt,
        phone: phone,
        fcmToken: fcmToken!,
      ),
    );

    setState(() => _isLoading = false);

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: Colors.redAccent,
          ),
        );
      },
      (_) {
        Navigator.pop(context, true); // Sinaliza sucesso
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          top: 24,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Preencha seus dados',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 24),
              _buildField(
                controller: _nameController,
                label: 'Nome completo',
                hint: 'Digite seu nome',
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Informe seu nome' : null,
              ),
              const SizedBox(height: 16),
              _buildField(
                controller: _ageController,
                label: 'Idade',
                hint: 'Ex: 25',
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe sua idade';
                  final age = int.tryParse(v);
                  if (age == null || age <= 0) return 'Idade inválida';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildField(
                controller: _churchController,
                label: 'Igreja',
                hint: 'Opcional',
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.copper,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Confirmar Inscrição',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    String? hint,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelStyle: TextStyle(color: AppColors.primaryColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.sage.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
