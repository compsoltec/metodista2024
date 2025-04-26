import 'package:http/http.dart' as http;

import '../../../../../core/core.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/event_repository.dart';
import '../models/event_models.dart';
import '../models/registration_models.dart';

class EventRepositoryImpl implements EventRepository {
  final http.Client client;

  EventRepositoryImpl(this.client);

  @override
  Future<Either<Failure, List<Event>>> getEvents() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/events'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'Success' &&
            responseData['data'] != null) {
          final List<dynamic> data = responseData['data'];
          List<Event> events =
              data.map((json) => EventModel.fromJson(json)).toList();
          return Right(events);
        } else {
          return Left(DatabaseFailure('Failed to parse events data'));
        }
      } else {
        return Left(DatabaseFailure('Failed to fetch events'));
      }
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch events: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Event>> getEventById(String eventId) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/events/$eventId'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'Success' &&
            responseData['data'] != null) {
          return Right(EventModel.fromJson(responseData['data']));
        } else {
          return Left(DatabaseFailure('Failed to parse event data'));
        }
      } else {
        return Left(DatabaseFailure('Failed to fetch event'));
      }
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch event: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Event>> createEvent(Event event) async {
    try {
      final eventModel = event as EventModel;
      final response = await client.post(
        Uri.parse('$baseUrl/events'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(eventModel.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'Success' &&
            responseData['data'] != null) {
          return Right(EventModel.fromJson(responseData['data']));
        } else {
          return Left(DatabaseFailure('Failed to parse created event data'));
        }
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        final String errorMessage =
            errorData['message'] ?? 'Failed to create event';
        return Left(DatabaseFailure(errorMessage));
      }
    } catch (e) {
      return Left(DatabaseFailure('Failed to create event: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Event>> updateEvent(Event event) async {
    try {
      final eventModel = event as EventModel;
      final response = await client.put(
        Uri.parse('$baseUrl/events/${event.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(eventModel.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'Success' &&
            responseData['data'] != null) {
          return Right(EventModel.fromJson(responseData['data']));
        } else {
          return Left(DatabaseFailure('Failed to parse updated event data'));
        }
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        final String errorMessage =
            errorData['message'] ?? 'Failed to update event';
        return Left(DatabaseFailure(errorMessage));
      }
    } catch (e) {
      return Left(DatabaseFailure('Failed to update event: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEvent(String eventId) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/events/$eventId'),
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        final String errorMessage =
            errorData['message'] ?? 'Failed to delete event';
        return Left(DatabaseFailure(errorMessage));
      }
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete event: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Registration>> registerForEvent(
      String eventId, Registration registration) async {
    try {
      final registrationModel = RegistrationModel(
        id: registration.id,
        eventId: registration.eventId,
        name: registration.name,
        age: registration.age,
        phone: registration.phone,
        church: registration.church,
        createdAt: registration.createdAt,
        fcmToken: registration.fcmToken,
      );
      final response = await client.post(
        Uri.parse('$baseUrl/events/$eventId/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(registrationModel.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'Success' &&
            responseData['data'] != null &&
            responseData['data']['registration'] != null) {
          return Right(
              RegistrationModel.fromJson(responseData['data']['registration']));
        } else {
          return Left(DatabaseFailure('Failed to parse registration data'));
        }
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        final String errorMessage =
            errorData['message'] ?? 'Failed to register for event';
        return Left(DatabaseFailure(errorMessage));
      }
    } catch (e) {
      return Left(
          DatabaseFailure('Failed to register for event: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Registration>>> getEventRegistrations(
      String eventId) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/events/$eventId/registrations'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'Success' &&
            responseData['data'] != null &&
            responseData['data']['registrations'] != null) {
          final List<dynamic> registrationsData =
              responseData['data']['registrations'];
          final List<Registration> registrations = registrationsData
              .map((json) => RegistrationModel.fromJson(json))
              .toList();
          return Right(registrations);
        } else {
          return Left(DatabaseFailure('Failed to parse registrations data'));
        }
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        final String errorMessage =
            errorData['message'] ?? 'Failed to get event registrations';
        return Left(DatabaseFailure(errorMessage));
      }
    } catch (e) {
      return Left(DatabaseFailure(
          'Failed to get event registrations: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelRegistration(
      String eventId, String registrationId) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/events/$eventId/registrations/$registrationId'),
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        final String errorMessage =
            errorData['message'] ?? 'Failed to cancel registration';
        return Left(DatabaseFailure(errorMessage));
      }
    } catch (e) {
      return Left(
          DatabaseFailure('Failed to cancel registration: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Registration>>> getRegistrationsByFcmToken(
      String eventId, String fcmToken) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/events/$eventId/registrations/token/$fcmToken'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'Success' &&
            responseData['data'] != null) {
          final List<dynamic> registrationsData = responseData['data'];
          final List<Registration> registrations = registrationsData
              .map((json) => RegistrationModel.fromJson(json))
              .toList();
          return Right(registrations);
        } else {
          return Left(DatabaseFailure('No registrations found'));
        }
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        final String errorMessage =
            errorData['message'] ?? 'Failed to fetch registrations';
        return Left(DatabaseFailure(errorMessage));
      }
    } catch (e) {
      return Left(
          DatabaseFailure('Error fetching registrations: ${e.toString()}'));
    }
  }
}
