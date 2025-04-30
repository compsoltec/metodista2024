import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../core/core.dart';
import '../../../app.dart';

class AllAudioScreen extends StatefulWidget {
  const AllAudioScreen({super.key});

  @override
  State<AllAudioScreen> createState() => _AllAudioScreenState();
}

class _AllAudioScreenState extends State<AllAudioScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AudioPlayer _audioPlayer;
  String? _currentPlayingUrl;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _audioPlayer = AudioPlayer();

    // Ao entrar na tela, já buscar os áudios
    context.read<DevotionalBloc>().add(FetchDevotionals());
    context.read<PreachingBloc>().add(FetchPreachings());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playAudio(String url) async {
    if (_currentPlayingUrl == url && _audioPlayer.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
      _currentPlayingUrl = url;
    }
    setState(() {}); // Atualiza ícones de play/pause
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DevotionalBloc>(
            create: (_) => sl<DevotionalBloc>()..add(FetchDevotionals())),
        BlocProvider<PreachingBloc>(
            create: (_) => sl<PreachingBloc>()..add(FetchPreachings())),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.white),
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Áudios',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Devocionais'),
              Tab(text: 'Pregações'),
            ],
            labelColor: AppColors.gold,
            unselectedLabelColor: Colors.white70,
            indicatorColor: AppColors.gold,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildDevotionalsList(),
            _buildPreachingsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDevotionalsList() {
    return BlocBuilder<DevotionalBloc, DevotionalState>(
      builder: (context, state) {
        if (state is DevotionalLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DevotionalLoaded) {
          final devotionals = state.devotionals;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: devotionals.length,
            itemBuilder: (context, index) {
              final devotional = devotionals[index];
              return _buildAudioCard(
                title: devotional.title,
                author: devotional.author,
                imageUrl: devotional.imageUrl,
                audioUrl: devotional.audioUrl,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          DevotionalDetailPage(devotional: devotional),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is DevotionalError) {
          return Center(
            child: Text(
              'Erro: ${state.message}',
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPreachingsList() {
    return BlocBuilder<PreachingBloc, PreachingState>(
      builder: (context, state) {
        if (state is PreachingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PreachingLoaded) {
          final preachings = state.preachings;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: preachings.length,
            itemBuilder: (context, index) {
              final preaching = preachings[index];
              return _buildAudioCard(
                title: preaching.title,
                author: preaching.author,
                imageUrl: preaching.imageUrl,
                audioUrl: preaching.audioUrl,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DevotionalDetailPage(
                        devotional: Devotional(
                          id: preaching.id,
                          title: preaching.title,
                          audioUrl: preaching.audioUrl,
                          author: preaching.author,
                          imageUrl: preaching.imageUrl,
                          date: '',
                          description: '',
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is PreachingError) {
          return Center(
            child: Text(
              'Erro: ${state.message}',
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAudioCard({
    required String title,
    required String author,
    required String imageUrl,
    required String audioUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkPurple.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'por $author',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  StreamBuilder<Duration>(
                    stream: _audioPlayer.positionStream,
                    builder: (context, snapshot) {
                      final position = snapshot.data ?? Duration.zero;
                      final total =
                          _audioPlayer.duration ?? const Duration(seconds: 1);

                      final progress = (_currentPlayingUrl == audioUrl)
                          ? (position.inMilliseconds / total.inMilliseconds)
                              .clamp(0.0, 1.0)
                          : 0.0;

                      return LinearProgressIndicator(
                        value: progress > 1 ? 1 : progress,
                        backgroundColor: AppColors.sage.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation(AppColors.copper),
                        minHeight: 4,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _playAudio(audioUrl),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.copper,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  (_currentPlayingUrl == audioUrl && _audioPlayer.playing)
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
