// event_event.dart
import '../../domain/entities/entities.dart';

abstract class CourcesCources {}

class FetchCources extends CourcesCources {}

class CreateCources extends CourcesCources {
  final Cources cources;

  CreateCources(this.cources);
}

class UpdateCources extends CourcesCources {
  final Cources cources;

  UpdateCources(this.cources);
}

class DeleteCources extends CourcesCources {
  final String eventId;

  DeleteCources(this.eventId);
}

class GetCourcesDetails extends CourcesCources {
  final String eventId;
  GetCourcesDetails(this.eventId);
}
