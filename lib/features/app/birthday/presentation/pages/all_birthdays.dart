import 'package:flutter/material.dart';
import 'package:metodista/core/core.dart';

import '../../../app.dart';

class AllBirthdaysScreen extends StatefulWidget {
  const AllBirthdaysScreen({super.key});

  @override
  State<AllBirthdaysScreen> createState() => _AllBirthdaysScreenState();
}

class _AllBirthdaysScreenState extends State<AllBirthdaysScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  @override
  void initState() {
    super.initState();
    final currentMonth = DateTime.now().month;
    _tabController = TabController(
        length: months.length, vsync: this, initialIndex: currentMonth - 1);

    // Busca aniversariantes
    context.read<BirthdayBloc>().add(FetchBirthdays());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Map<int, List<Birthday>> groupByMonth(List<Birthday> birthdays) {
    final Map<int, List<Birthday>> grouped = {};

    for (var birthday in birthdays) {
      final month = birthday.birthDate.month;
      if (!grouped.containsKey(month)) {
        grouped[month] = [];
      }
      grouped[month]!.add(birthday);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: const Text(
          'Aniversariantes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: const Color(0xFFC99058),
          unselectedLabelColor: Colors.white70,
          indicatorColor: const Color(0xFFC99058),
          tabs: months.map((month) => Tab(text: month)).toList(),
        ),
      ),
      body: BlocBuilder<BirthdayBloc, BirthdayState>(
        builder: (context, state) {
          if (state is BirthdayLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BirthdayLoaded) {
            final grouped = groupByMonth(state.birthdays);

            return TabBarView(
              controller: _tabController,
              children: List.generate(12, (index) {
                final monthIndex = index + 1;
                final monthBirthdays = grouped[monthIndex] ?? [];

                if (monthBirthdays.isEmpty) {
                  return Center(
                    child: Text(
                      'Nenhum aniversariante em ${months[index]}',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: monthBirthdays.length,
                  itemBuilder: (context, i) {
                    final birthday = monthBirthdays[i];
                    final formattedDate =
                        DateFormat('dd/MM').format(birthday.birthDate);

                    return Card(
                      color: const Color(0xFFF5F5F5),
                      elevation: 5,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFFC99058),
                          radius: 28, // Aumenta um pouco para a data caber bem
                          child: Text(
                            '${DateFormat('dd').format(birthday.birthDate)}/${DateFormat('MM').format(birthday.birthDate)}', // <-- Data formatada só o dia
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          birthday.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E1A47),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.cake,
                          color: Color(0xFFC99058),
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          } else if (state is BirthdayError) {
            return Center(
              child: Text(
                'Erro: ${state.message}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
