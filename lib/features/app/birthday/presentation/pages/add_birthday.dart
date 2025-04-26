import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../bloc/bloc.dart';

class AddBirthdayPage extends StatefulWidget {
  const AddBirthdayPage({super.key});

  @override
  State<AddBirthdayPage> createState() => _AddBirthdayPageState();
}

class _AddBirthdayPageState extends State<AddBirthdayPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Novo Aniversariante',
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocListener<BirthdayBloc, BirthdayState>(
        listener: (context, state) {
          if (state is BirthdayLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              ),
            );
          } else if (state is BirthdaySuccess) {
            Navigator.of(context).pop(); // Fecha o loading
            Get.back(); // Volta para a tela anterior
            Get.snackbar('Sucesso', state.message,
                backgroundColor: Colors.green, colorText: Colors.white);
          } else if (state is BirthdayError) {
            Navigator.of(context).pop(); // Fecha o loading
            Get.snackbar('Erro', state.message,
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: const TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.gold)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.gold)),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Informe o nome' : null,
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Text(
                    _selectedDate == null
                        ? 'Selecionar Data de Nascimento'
                        : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing:
                      const Icon(Icons.calendar_today, color: AppColors.gold),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() => _selectedDate = picked);
                    }
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _selectedDate != null) {
                      context.read<BirthdayBloc>().add(
                            CreateBirthdayEvent(
                              name: _nameController.text,
                              birthDate: _selectedDate!,
                            ),
                          );
                    } else {
                      Get.snackbar('Atenção',
                          'Preencha o nome e selecione a data de nascimento',
                          backgroundColor: Colors.orange,
                          colorText: Colors.black);
                    }
                  },
                  child: const Text('Salvar',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
