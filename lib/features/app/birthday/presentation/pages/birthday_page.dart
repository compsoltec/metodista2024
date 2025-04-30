import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../app.dart';

class BirthdayPage extends StatefulWidget {
  const BirthdayPage({super.key});

  @override
  State<BirthdayPage> createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: months.length, vsync: this);
    context.read<BirthdayBloc>().add(FetchBirthdays());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Aniversariantes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.sage,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: months.map((month) => Tab(text: month)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.sage,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Get.toNamed(Routes.addBirthday);
        },
      ),
      body: BlocListener<BirthdayBloc, BirthdayState>(
        listener: (context, state) {
          if (state is BirthdaySuccess) {
            Get.snackbar('Sucesso', state.message,
                backgroundColor: Colors.green, colorText: Colors.white);
          } else if (state is BirthdayError) {
            Get.snackbar('Erro', state.message,
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        },
        child: BlocBuilder<BirthdayBloc, BirthdayState>(
          builder: (context, state) {
            if (state is BirthdayLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BirthdayLoaded) {
              return _buildTabs(state);
            } else if (state is BirthdayError) {
              return Center(
                child: Text(state.message,
                    style: const TextStyle(color: Colors.white)),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildTabs(BirthdayLoaded state) {
    return TabBarView(
      controller: _tabController,
      children: months.map((month) {
        final monthIndex = months.indexOf(month) + 1;

        final birthdaysOfMonth = state.birthdays
            .where((b) => b.birthDate.month == monthIndex)
            .toList();

        if (birthdaysOfMonth.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum aniversariante 🥲',
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return ListView.builder(
          itemCount: birthdaysOfMonth.length,
          itemBuilder: (context, index) {
            final birthday = birthdaysOfMonth[index];
            return ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.sage,
                child: Icon(Icons.cake, color: Colors.white),
              ),
              title: Text(
                birthday.name,
                style: const TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                DateFormat('dd MMMM').format(birthday.birthDate),
                style: const TextStyle(color: Colors.black),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  context
                      .read<BirthdayBloc>()
                      .add(DeleteBirthdayEvent(birthday.id));
                },
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
