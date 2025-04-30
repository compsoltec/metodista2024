import 'package:flutter/material.dart';
import 'package:metodista/features/app/preaching/presentation/pages/addpreachings_page.dart';

import '../../../../../core/core.dart';
import '../../../app.dart';
import '../../../notices/notices.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        title: const Text(
          'Painel Administrativo',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        backgroundColor: AppColors.darkPurple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bem-vindo(a), Admin!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.darkPurple,
              ),
            ),
            const SizedBox(height: 24),
            _buildAdminMenu(context),
            const SizedBox(height: 40),
            const Text(
              'Atalhos Rápidos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.copper,
              ),
            ),
            const SizedBox(height: 16),
            _buildQuickActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminMenu(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMenuCard(
              icon: Icons.event,
              label: 'Criar\nEvento',
              color: AppColors.sage,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateEventScreen()),
                );
              },
            ),
            _buildMenuCard(
              icon: Icons.library_music,
              label: 'Criar\nDevocional',
              color: AppColors.copper,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddDevotionalPage()),
                );
              },
            ),
            _buildMenuCard(
              icon: Icons.cake,
              label: 'Aniversariantes',
              color: AppColors.gold,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BirthdayPage()),
                );
              },
            ),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMenuCard(
              icon: Icons.menu_book,
              label: 'Criar\nPastoral',
              color: AppColors.gold,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddPastoralPage()),
                );
              },
            ),
            _buildMenuCard(
              icon: Icons.library_music,
              label: 'Adicionar\nPregação',
              color: AppColors.sage,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddPreachingPage()),
                );
              },
            ),
            _buildMenuCard(
              icon: Icons.book,
              label: 'Adicionar\nCurso',
              color: AppColors.copper,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CreateCourcesScreen()),
                );
              },
            ),
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMenuCard(
              icon: Icons.people,
              label: 'Adicionar\nCélula',
              color: AppColors.copper,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateCellsScreen()),
                );
              },
            ),
            _buildMenuCard(
              icon: Icons.video_collection,
              label: 'Adicionar\nVídeos',
              color: AppColors.gold,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CreateNoticesScreen()),
                );
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      children: [
        _buildQuickActionCard(
          icon: Icons.list,
          color: AppColors.darkPurple,
          title: 'Ver Eventos Recentes',
          onTap: () {
            // Navegar para lista de eventos
          },
        ),
        const SizedBox(height: 12),
        _buildQuickActionCard(
          icon: Icons.music_note,
          color: AppColors.gold,
          title: 'Ver Devocionais Recentes',
          onTap: () {
            // Navegar para lista de devocionais
          },
        ),
        const SizedBox(height: 12),
        _buildQuickActionCard(
          icon: Icons.cake_outlined,
          color: AppColors.sage,
          title: 'Ver Aniversariantes',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BirthdayPage()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
