import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../app.dart';

class CourcesListScreen extends StatelessWidget {
  final Cources cources;

  const CourcesListScreen({super.key, required this.cources});

  void _openWhatsApp(String phone) async {
    // Remove qualquer caractere não numérico
    String formattedPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');

    // Adiciona o código do país (Brasil = 55) se não tiver
    if (!formattedPhone.startsWith('55')) {
      formattedPhone = '55$formattedPhone';
    }

    final url = 'https://wa.me/$formattedPhone';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Não foi possível abrir o WhatsApp');
    }
  }

  void _registerCourse(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Inscrição realizada com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
    // Aqui você pode adicionar a lógica para processar a inscrição
    // Por exemplo, navegar para uma página de formulário ou abrir um modal
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(right: 16, bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 280, // Largura fixa para melhor alinhamento horizontal
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho do curso
            Text(
              cources.course,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Informações do instrutor
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagem do instrutor
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 80,
                    width: 80,
                    color: Colors.grey.shade200, // Cor de fallback
                    child: Image.network(
                      cources.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Detalhes do instrutor
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cources.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Telefone com botão de WhatsApp
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 14,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              cources.phone.toString(),
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                _openWhatsApp(cources.phone.toString()),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFF25D366), // Cor do WhatsApp
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.chat,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Botão de inscrição (mostrado apenas se registration for true)
            if (cources.inscricoes == true) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _registerCourse(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.copper,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    'Inscrever-se',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
