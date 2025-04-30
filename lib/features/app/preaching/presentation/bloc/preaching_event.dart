part of 'preaching_bloc.dart';

abstract class PreachingEvent {}

class FetchPreachings extends PreachingEvent {}

class AddPreaching extends PreachingEvent {
  final Preaching preaching;

  AddPreaching(this.preaching);
}

class RemovePreaching extends PreachingEvent {
  final String preachingId;

  RemovePreaching(this.preachingId);
}
