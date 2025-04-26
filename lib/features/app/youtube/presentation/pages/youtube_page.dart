import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../youtube.dart';
import 'youtube_video_player.dart';

class YoutubePage extends StatelessWidget {
  const YoutubePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkPurple,
      body: BlocProvider(
        create: (_) => sl<YoutubeBloc>()..add(FetchYoutubeVideos()),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: BlocBuilder<YoutubeBloc, YoutubeState>(
              builder: (context, state) {
                if (state is YoutubeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(AppColors.gold),
                    ),
                  );
                } else if (state is YoutubeLoaded) {
                  final videos = state.videos;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Topo minimalista
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white70,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: 10),

                        const SizedBox(height: 24),

                        // Destaque sem gradiente pesado
                        _buildFeaturedVideo(videos[0], context),

                        const SizedBox(height: 30),

                        _buildSectionHeader('Continue assistindo'),
                        const SizedBox(height: 12),
                        _buildHorizontalList(videos),

                        const SizedBox(height: 30),

                        _buildSectionHeader('Novos Vídeos'),
                        const SizedBox(height: 12),
                        _buildGridVideos(videos),
                      ],
                    ),
                  );
                } else if (state is YoutubeError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedVideo(YoutubeVideo video, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => YoutubeVideoPlayerPage(videoId: video.id),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          'https://img.youtube.com/vi/${video.id}/hqdefault.jpg',
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.gold,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
      ],
    );
  }

  Widget _buildHorizontalList(List<YoutubeVideo> videos) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length > 5 ? 5 : videos.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final video = videos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      YoutubeVideoPlayerPage(videoId: video.id),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://img.youtube.com/vi/${video.id}/hqdefault.jpg',
                width: 180,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridVideos(List<YoutubeVideo> videos) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 16 / 11,
      ),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => YoutubeVideoPlayerPage(videoId: video.id),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://img.youtube.com/vi/${video.id}/hqdefault.jpg',
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
