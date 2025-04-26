part of 'devotional_bloc.dart';

abstract class DevotionalEvent {}

class FetchDevotionals extends DevotionalEvent {}

class AddDevotional extends DevotionalEvent {
  final Devotional devotional;

  AddDevotional(this.devotional);
}

class RemoveDevotional extends DevotionalEvent {
  final String devotionalId;

  RemoveDevotional(this.devotionalId);
}
