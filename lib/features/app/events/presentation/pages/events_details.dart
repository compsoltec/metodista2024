// event_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metodista/features/app/events/domain/entities/entities.dart';

import '../../../../../core/core.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final dateFormat = DateFormat("d 'de' MMMM 'às' HH:mm", 'pt_BR');
  Event? event;
  late PaletteGenerator _paletteGenerator;
  bool _isLoadingPalette = true;
  bool isImageDark = true;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Event;
    event = args;
    _generatePalette();

    // agora você pode usar eventId normalmente para buscar informações
  }

  String _formatEventDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return dateFormat.format(date);
    } catch (e) {
      return dateString; // Return original if parsing fails
    }
  }

  Future<void> _generatePalette() async {
    final imageProvider = NetworkImage(event!.imageUrl);
    _paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);

    final dominantColor = _paletteGenerator.dominantColor?.color;

    setState(() {
      isImageDark = (dominantColor?.computeLuminance() ?? 1.0) < 0.5;
      _isLoadingPalette = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = isImageDark ? Colors.white : Colors.black;
    final statusBarStyle =
        isImageDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6E3),
      body: _isLoadingPalette
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  systemOverlayStyle: statusBarStyle,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: iconColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                    title: Text(
                      event!.title,
                      style: TextStyle(
                        color: iconColor,
                        shadows: [
                          Shadow(
                            color:
                                isImageDark ? Colors.black54 : Colors.white54,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                    background:
                        Image.network(event!.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoCard(Icons.calendar_today, 'Data',
                            _formatEventDate(event!.eventDate)),
                        _buildInfoCard(
                            Icons.location_on, 'Local', event!.location),
                        _buildInfoCard(Icons.people, 'Vagas disponíveis',
                            event!.capacity.toString()),
                        const SizedBox(height: 24),
                        const Text(
                          'Sobre o Evento',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF322938),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          event!.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4A4A4A),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.check_circle_outline),
                            label: const Text('Quero me Inscrever'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: const Color(0xFFCC883A),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF89A194).withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF89A194)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF322938),
                      fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style:
                      const TextStyle(fontSize: 15, color: Color(0xFF4A4A4A))),
            ],
          ),
        ],
      ),
    );
  }
}
