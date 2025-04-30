// event_event.dart
import '../../domain/entities/entities.dart';

abstract class NoticesEvent {}

class FetchNotices extends NoticesEvent {}

class CreateNotices extends NoticesEvent {
  final Notices notices;

  CreateNotices(this.notices);
}

class UpdateNotices extends NoticesEvent {
  final Notices notices;

  UpdateNotices(this.notices);
}

class DeleteNotices extends NoticesEvent {
  final String eventId;

  DeleteNotices(this.eventId);
}

class GetNoticesDetails extends NoticesEvent {
  final String eventId;
  GetNoticesDetails(this.eventId);
}
