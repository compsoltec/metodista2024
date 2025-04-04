import '../../../../core/core.dart';
import '../../events.dart';

class AddEventUseCase {
  final EventRepository repository;

  AddEventUseCase(this.repository);

  Future<Either<Failure, Event>> call(AddEventParams params) async {
    return await repository.addEvent(Event(
      id: '',
      name: params.name,
      description: params.description,
      date: params.date,
    ));
  }
}

class AddEventParams extends Equatable {
  final String name;
  final String description;
  final DateTime date;

  const AddEventParams({
    required this.name,
    required this.description,
    required this.date,
  });

  @override
  List<Object?> get props => [name, description, date];
}
