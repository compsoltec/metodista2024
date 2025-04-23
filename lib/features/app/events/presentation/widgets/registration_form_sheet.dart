// class RegistrationFormSheet extends StatefulWidget {
//   final String eventId;
//   final String userPhone;
//   final String fcmToken;

//   const RegistrationFormSheet({
//     super.key,
//     required this.eventId,
//     required this.userPhone,
//     required this.fcmToken,
//   });

//   @override
//   State<RegistrationFormSheet> createState() => _RegistrationFormSheetState();
// }

// class _RegistrationFormSheetState extends State<RegistrationFormSheet> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _churchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         left: 16,
//         right: 16,
//         top: 16,
//       ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               'Inscrição para o Evento',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.white,
//               ),
//             ),
//             const SizedBox(height: 24),
//             TextFormField(
//               controller: _nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Nome Completo',
//                 labelStyle: TextStyle(color: AppColors.gold),
//               ),
//               style: const TextStyle(color: AppColors.white),
//               validator: (value) =>
//                   value?.isEmpty ?? true ? 'Campo obrigatório' : null,
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _ageController,
//               decoration: const InputDecoration(
//                 labelText: 'Idade',
//                 labelStyle: TextStyle(color: AppColors.gold),
//               ),
//               keyboardType: TextInputType.number,
//               style: const TextStyle(color: AppColors.white),
//               validator: (value) {
//                 if (value?.isEmpty ?? true) return 'Campo obrigatório';
//                 final age = int.tryParse(value!);
//                 if (age == null || age <= 0) return 'Idade inválida';
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _churchController,
//               decoration: const InputDecoration(
//                 labelText: 'Igreja (opcional)',
//                 labelStyle: TextStyle(color: AppColors.gold),
//               ),
//               style: const TextStyle(color: AppColors.white),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: _submitForm,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.gold,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//               ),
//               child: const Text(
//                 'Confirmar Inscrição',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   void _submitForm() {
//     if (_formKey.currentState?.validate() ?? false) {
//       context.read<EventDetailsBloc>().add(
//             RegisterForEvent(
//               fcmToken: widget.fcmToken,
//               eventId: widget.eventId,
//               name: _nameController.text,
//               age: int.parse(_ageController.text),
//               phone: widget.userPhone,
//               church: _churchController.text,
//             ),
//           );
//       Navigator.pop(context);
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _ageController.dispose();
//     _churchController.dispose();
//     super.dispose();
//   }
// }
