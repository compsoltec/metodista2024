import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metodista/features/app/bible/presentation/bible_book.dart';
import 'package:metodista/features/app/birthday/presentation/pages/all_birthdays.dart';
import 'package:metodista/features/app/events/presentation/pages/all_events.dart';
import 'package:metodista/features/app/notices/notices.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';
import '../../../admin/presentation/pages/admin_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<DevotionalBloc>()..add(FetchDevotionals()),
          ),
          BlocProvider(
            create: (_) => sl<PreachingBloc>()..add(FetchPreachings()),
          ),
          BlocProvider(
            create: (_) => sl<CourcesBloc>()..add(FetchCources()),
          ),
          BlocProvider(
            create: (_) => sl<CellsBloc>()..add(FetchCells()),
          ),
          BlocProvider(
            create: (_) => sl<NoticesBloc>()..add(FetchNotices()),
          ),
        ],
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    child: Image.asset(
                      'assets/novotemplo.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.gradientStart.withOpacity(0.6),
                          AppColors.gradientEnd.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: WelcomeHeader()),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: BlocBuilder<PreachingBloc, PreachingState>(
                        builder: (context, state) {
                          if (state is PreachingLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is PreachingLoaded) {
                            final preachings = state.preachings;
                            if (preachings.isEmpty) {
                              return const SizedBox();
                            } else {
                              return PreachingPage(
                                preachings: preachings,
                              );
                            }
                          } else if (state is PreachingError) {
                            return Text(state.message);
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  // Conteúdo Principal SEM o Transform.translate
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.darkPurple.withOpacity(0.1),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<NoticesBloc, NoticesState>(
                            builder: (context, state) {
                              if (state is NoticesLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is NoticessLoaded) {
                                final notices = state.notices;
                                if (notices.isEmpty) return const SizedBox();
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: MediaPlayerWidget(notices: notices),
                                  ),
                                );
                              } else if (state is NoticesError) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Text(state.message,
                                      style: TextStyle(color: Colors.red)),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Menu',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildQuickAccessGrid(),
                              ],
                            ),
                          ),
                          //const SizedBox(height: 32),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 24),
                          //   child: EventsSection(),
                          // ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 0),
                            child: Text(
                              'Nossos Cursos',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: BlocBuilder<CourcesBloc, CourcesState>(
                              builder: (context, state) {
                                if (state is PreachingLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is CourcessLoaded) {
                                  final cources = state.cources;
                                  if (cources.isEmpty) {
                                    return const SizedBox();
                                  } else {
                                    return SizedBox(
                                      height: 210,
                                      child: ListView.builder(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap:
                                              true, // <- Adicione isso também pra funcionar dentro do ScrollView

                                          itemCount: cources.length,
                                          itemBuilder: (context, index) {
                                            return CourcesListScreen(
                                              cources: cources[index],
                                            );
                                          }),
                                    );
                                  }
                                } else if (state is CourcesError) {
                                  return Text(state.message);
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 0),
                            child: Text(
                              'Nossas Células',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: BlocBuilder<CellsBloc, CellsState>(
                              builder: (context, state) {
                                if (state is CellsLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is CellssLoaded) {
                                  final cells = state.cells;
                                  if (cells.isEmpty) {
                                    return const SizedBox();
                                  } else {
                                    return SizedBox(
                                      height: 210,
                                      child: ListView.builder(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap:
                                              true, // <- Adicione isso também pra funcionar dentro do ScrollView

                                          itemCount: cells.length,
                                          itemBuilder: (context, index) {
                                            return CellsListScreen(
                                              cells: cells[index],
                                            );
                                          }),
                                    );
                                  }
                                } else if (state is CellsError) {
                                  return Text(state.message);
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: BirthdaysSection(),
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: PastoralsSection(),
                          ),
                          SizedBox(
                            height: 130,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: BlocBuilder<DevotionalBloc, DevotionalState>(
                  builder: (context, state) {
                    if (state is DevotionalLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DevotionalLoaded) {
                      final devotionals = state.devotionals;
                      final devotionalMaisRecente =
                          devotionals.isNotEmpty ? devotionals.first : null;

                      if (devotionalMaisRecente == null) {
                        return const SizedBox();
                      }

                      return DevotionalPlayerWidget(
                        devotional: devotionalMaisRecente,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DevotionalDetailPage(
                                devotional: devotionalMaisRecente,
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is DevotionalError) {
                      return Text(state.message);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.darkPurple.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home,
                  label: 'Home',
                  isSelected: true,
                  onTap: () {
                    // Já está na Home, pode deixar vazio ou recarregar algo se quiser
                  },
                ),
                _buildNavItem(
                  icon: Icons.youtube_searched_for,
                  label: 'YouTube',
                  isSelected: false,
                  onTap: () {
                    Get.toNamed(Routes.youtube);
                  },
                ),
                _buildNavItem(
                  icon: Icons.edit_document,
                  label: 'Documentos',
                  isSelected: false,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Funcionalidade de Documentos em desenvolvimento!')),
                    );
                  },
                ),
                _buildNavItem(
                  icon: Icons.chat,
                  label: 'Chat',
                  isSelected: false,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Funcionalidade de Chat em desenvolvimento!')),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAccessGrid() {
    final List<Map<String, dynamic>> quickActions = [
      {
        'icon': Icons.calendar_today,
        'label': 'Eventos',
        'color': AppColors.copper
      },
      {
        'icon': Icons.card_giftcard,
        'label': 'Aniversario',
        'color': AppColors.sage
      },
      {'icon': Icons.message, 'label': 'Chat', 'color': AppColors.gold},
      {'icon': Icons.book, 'label': 'Bíblia', 'color': AppColors.rust},
      {
        'icon': Icons.music_note,
        'label': 'Playlists',
        'color': AppColors.darkPurple
      },
      {'icon': Icons.group, 'label': 'Acessos', 'color': AppColors.copper},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: quickActions.length,
      itemBuilder: (context, index) {
        final action = quickActions[index];
        return _buildQuickActionCard(
          icon: action['icon'],
          label: action['label'],
          color: action['color'],
          onTap: () {
            switch (action['label']) {
              case 'Acessos':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AdminDashboardPage()),
                );
                break;
            }
            switch (action['label']) {
              case 'Aniversario':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AllBirthdaysScreen()),
                );
                break;
            }
            switch (action['label']) {
              case 'Playlists':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AllAudioScreen()),
                );
                break;
            }
            switch (action['label']) {
              case 'Bíblia':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BibleBooksScreen()),
                );
                break;
            }
            switch (action['label']) {
              case 'Eventos':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AllEventsPage()),
                );
                break;
            }
          },
        );
      },
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 26,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      {required IconData icon,
      required String label,
      required bool isSelected,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.copper : AppColors.textSecondary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.copper : AppColors.textSecondary,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
