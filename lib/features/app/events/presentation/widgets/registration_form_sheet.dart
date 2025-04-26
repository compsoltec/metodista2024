import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/event_repository.dart';

class RegistrationForm extends StatelessWidget {
  final String eventId;
  final EventRepository repository;

  RegistrationForm({
    super.key,
    required this.eventId,
    required this.repository,
  });

  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final churchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(label: Text('Nome Completo')),
              validator: (v) => v!.isEmpty ? 'Informe o nome' : null),
          TextFormField(
              controller: ageCtrl,
              decoration: const InputDecoration(label: Text('Idade')),
              validator: (v) => v!.isEmpty ? 'Informe a idade' : null,
              keyboardType: TextInputType.number),
          TextFormField(
              controller: phoneCtrl,
              decoration: const InputDecoration(label: Text('Telefone')),
              validator: (v) => v!.isEmpty ? 'Informe o telefone' : null),
          TextFormField(
              controller: churchCtrl,
              decoration: const InputDecoration(label: Text('Igreja'))),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  // Obter o FCM Token atual
                  String? fcmToken =
                      await FirebaseMessaging.instance.getToken();

                  final reg = Registration(
                    id: '',
                    eventId: eventId,
                    name: nameCtrl.text,
                    age: int.parse(ageCtrl.text),
                    church: churchCtrl.text,
                    phone: phoneCtrl.text,
                    createdAt: DateTime.now().toIso8601String(),
                    fcmToken: fcmToken!,
                  );

                  final result =
                      await repository.registerForEvent(eventId, reg);

                  result.fold(
                    (error) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro: ${error.message}'))),
                    (_) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Inscrição realizada com sucesso!')));
                      Navigator.pop(context);
                    },
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro inesperado: ${e.toString()}')),
                  );
                }
              }
            },
            child: const Text('Confirmar'),
          ),
        ]),
      ),
    );
  }
}
