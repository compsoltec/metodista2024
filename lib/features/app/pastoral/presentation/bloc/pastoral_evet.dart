import '../../domain/domain.dart';

abstract class PastoralEvent {}

class FetchPastoralsEvent extends PastoralEvent {}

class GetPastoralByIdEvent extends PastoralEvent {
  final String id;
  GetPastoralByIdEvent(this.id);
}

class CreatePastoralEvent extends PastoralEvent {
  final String title;
  final String text;
  final String author;
  final DateTime date;
  final List<String> imageUrls;

  CreatePastoralEvent(
      {required this.title,
      required this.text,
      required this.author,
      required this.date,
      required this.imageUrls});
}

class UpdatePastoralEvent extends PastoralEvent {
  final Pastoral pastoral;
  UpdatePastoralEvent(this.pastoral);
}

class DeletePastoralEvent extends PastoralEvent {
  final String id;
  DeletePastoralEvent(this.id);
}
