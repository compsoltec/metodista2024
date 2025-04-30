import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../pastoral/pastoral.dart';

class PastoralsSection extends StatelessWidget {
  const PastoralsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PastoralBloc>()..add(FetchPastoralsEvent()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pastoral',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<PastoralBloc, PastoralState>(
            builder: (context, state) {
              if (state is PastoralSuccess) {
                Navigator.of(context).pop(); // Fecha o loading
                Get.back(); // Volta para a tela anterior
                Get.snackbar('Sucesso', state.message,
                    backgroundColor: Colors.green, colorText: Colors.white);
              } else if (state is PastoralError) {
                Navigator.of(context).pop(); // Fecha o loading
                Get.snackbar('Erro', state.message,
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
              if (state is PastoralLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PastoralLoaded) {
                final pastorals = state.pastorals;

                if (pastorals.isEmpty) {
                  return const Text(
                    'Nenhuma pastoral disponível.',
                    style: TextStyle(color: AppColors.textSecondary),
                  );
                }

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: pastorals.take(2).map((pastoral) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: AppColors.copper,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pastoral.author,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(pastoral.date),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Exibir imagem se houver
                            if (pastoral.imageUrls.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  pastoral.imageUrls.first,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                            const SizedBox(height: 12),
                            Text(
                              pastoral.text.length > 100
                                  ? '${pastoral.text.substring(0, 100)}...'
                                  : pastoral.text,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    // Navegar para detalhe da pastoral
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            PastoralScreen(pastoral: pastoral),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                    color: AppColors.copper,
                                    size: 16,
                                  ),
                                  label: const Text(
                                    'Ler mais',
                                    style: TextStyle(
                                      color: AppColors.copper,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              } else if (state is PastoralError) {
                return Text(state.message,
                    style: const TextStyle(color: Colors.redAccent));
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
