// event_details_screen.dart
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../events.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late final EventBloc eventBloc;
  late final PaletteGenerator _paletteGenerator;
  bool isImageDark = true;
  bool _isLoadingPalette = true;
  Event? event;
  List<Registration>? registrations;
  final dateFormat = DateFormat("d 'de' MMMM 'às' HH:mm", 'pt_BR');

  @override
  void initState() {
    super.initState();
    eventBloc = context.read<EventBloc>();
    event = Get.arguments as Event;

    _initializeData();
  }

  Future<void> _initializeData() async {
    await _generatePalette();

    // Carrega os participantes filtrando pelo FCM Token
    final repository = sl<EventRepository>();
    final result = await repository.getEventRegistrations(event!.id);

    result.fold(
      (error) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro: ${error.message}'))),
      (data) async {
        String? currentFcmToken = await FirebaseMessaging.instance.getToken();
        final filtered =
            data.where((reg) => reg.fcmToken == currentFcmToken).toList();
        setState(() => registrations = filtered);
      },
    );
  }

  Future<void> _generatePalette() async {
    _paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(event!.imageUrl),
    );
    final dominantColor = _paletteGenerator.dominantColor?.color;
    setState(() {
      isImageDark = (dominantColor?.computeLuminance() ?? 1.0) < 0.5;
      _isLoadingPalette = false;
    });
  }

  String _formatEventDate(String dateString) {
    return dateFormat.format(DateTime.parse(dateString));
  }

  void _showRegistrationForm(BuildContext context) async {
    final registered = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: RegistrationForm(
          repository: sl<EventRepository>(),
          eventId: event!.id,
        ),
      ),
    );

    if (registered == true) {
      // Recarrega os participantes
      _initializeData();
    }
  }

  void _showRegistrationsModal() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Todos os Inscritos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: registrations != null && registrations!.isNotEmpty
                  ? ListView.builder(
                      itemCount: registrations!.length,
                      itemBuilder: (_, index) {
                        final reg = registrations![index];
                        return ListTile(
                          leading: CircleAvatar(child: Text(reg.name[0])),
                          title: Text(reg.name),
                          subtitle: Text('${reg.age} anos • ${reg.church}'),
                        );
                      },
                    )
                  : Center(child: Text('Nenhum inscrito ainda')),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = isImageDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: _isLoadingPalette
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: iconColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    title:
                        Text(event!.title, style: TextStyle(color: iconColor)),
                    background:
                        Image.network(event!.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _info(Icons.calendar_today, 'Data',
                            _formatEventDate(event!.eventDate)),
                        _info(Icons.location_on, 'Local', event!.location),
                        _info(
                            Icons.people, 'Vagas', event!.capacity.toString()),
                        SizedBox(height: 24),
                        Text('Sobre o Evento',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 12),
                        Text(event!.description),
                        SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.copper,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            _showRegistrationForm(context);
                          },
                          child: Text('Quero me Inscrever',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                        SizedBox(height: 24),
                        _buildParticipantsSection(),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildParticipantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Participantes Inscritos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (registrations != null && registrations!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              '💡 Dica: Arraste para o lado para excluir uma inscrição',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
        if (registrations == null)
          Center(child: CircularProgressIndicator())
        else if (registrations!.isEmpty)
          Text('Nenhum inscrito ainda')
        else
          Column(
            children: [
              ...registrations!.take(3).map(
                    (reg) => Dismissible(
                      key: Key(reg.id), // Use o ID único da inscrição
                      direction: DismissDirection
                          .endToStart, // Arrastar da direita para a esquerda
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Confirmar Exclusão'),
                            content: Text(
                                'Deseja realmente excluir a inscrição de ${reg.name}?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text('Excluir'),
                              ),
                            ],
                          ),
                        );
                      },
                      onDismissed: (direction) async {
                        final result = await sl<EventRepository>()
                            .cancelRegistration(event!.id, reg.id);

                        result.fold(
                          (error) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Erro ao excluir: ${error.message}')),
                          ),
                          (_) {
                            setState(() {
                              registrations!.remove(reg);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Inscrição de ${reg.name} excluída!')),
                            );
                          },
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(child: Text(reg.name[0])),
                        title: Text(reg.name),
                        subtitle: Text(
                            '${reg.age} anos • ${reg.church ?? 'Igreja não informada'}'),
                      ),
                    ),
                  ),
              if (registrations!.length > 3)
                TextButton(
                  onPressed: _showRegistrationsModal,
                  child: Text('Ver todos (${registrations!.length})'),
                ),
            ],
          ),
      ],
    );
  }

  void _confirmDelete(Registration registration) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text(
            'Deseja realmente excluir a inscrição de ${registration.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteRegistration(registration);
            },
            child: Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteRegistration(Registration registration) async {
    final repository = sl<EventRepository>();
    final result =
        await repository.cancelRegistration(event!.id, registration.id);

    result.fold(
      (error) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir: ${error.message}')),
      ),
      (_) {
        setState(() {
          registrations!.removeWhere((r) => r.id == registration.id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Inscrição de ${registration.name} excluída com sucesso!')),
        );
      },
    );
  }

  Widget _info(IconData icon, String title, String subtitle) => Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.sage),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGray)),
                Text(subtitle, style: TextStyle(color: AppColors.darkGray)),
              ],
            ),
          ],
        ),
      );
}
