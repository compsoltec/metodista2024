import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../app.dart';

class BirthdaysSection extends StatelessWidget {
  const BirthdaysSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aniversariantes do Dia',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        BlocProvider(
          create: (_) => sl<BirthdayBloc>()..add(FetchBirthdaysTodayEvent()),
          child: BlocBuilder<BirthdayBloc, BirthdayState>(
            builder: (context, state) {
              if (state is BirthdayLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BirthdayLoadedToday) {
                final birthdays = state.birthdays;
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
                  child: birthdays.isEmpty
                      ? Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: AppColors.copper,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.cake,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: const Text(
                                'Nenhum aniversariante do dia',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.textSecondary,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: birthdays.map((birthday) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: AppColors.copper,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.cake,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          birthday.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd MMMM')
                                              .format(birthday.birthDate),
                                          style: const TextStyle(
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Aqui você pode abrir um WhatsApp, ou exibir uma mensagem
                                    },
                                    child: const Text(
                                      'Parabenizar',
                                      style: TextStyle(
                                        color: AppColors.copper,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                );
              } else if (state is BirthdayError) {
                return Text(state.message,
                    style: const TextStyle(color: Colors.redAccent));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
