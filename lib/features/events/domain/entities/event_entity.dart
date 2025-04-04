import '../../../../core/core.dart';

class Event extends Equatable {
  final String id;
  final String name;
  final String description;
  final DateTime date;

  const Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
  });

  @override
  List<Object?> get props => [id, name, description, date];
}
