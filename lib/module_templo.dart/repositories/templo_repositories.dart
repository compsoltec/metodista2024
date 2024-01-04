
import '../providers/templo_provider.dart';

class AgendaTemploRepository {
  final AgendaTemploProvider api;

  AgendaTemploRepository({required this.api});

  getAgendaTemplo() {
    return api.getAgendaTemplo();
  }
}
