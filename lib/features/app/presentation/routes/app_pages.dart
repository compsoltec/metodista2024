import '../../../../core/core.dart';
import '../../../features.dart';
import '../../events/events.dart';
import '../../youtube/youtube.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: Routes.addEvent,
      page: () => BlocProvider<EventBloc>(
        create: (context) => sl<EventBloc>(),
        child: CreateEventScreen(),
      ),
    ),
    GetPage(
      name: Routes.eventDetails,
      page: () => BlocProvider<EventBloc>(
        create: (context) => sl<EventBloc>(),
        child: EventDetailsScreen(),
      ),
    ),
    GetPage(
      name: Routes.adddevotionals,
      page: () => BlocProvider<DevotionalBloc>(
        create: (context) => sl<DevotionalBloc>(),
        child: AddDevotionalPage(),
      ),
    ),
    GetPage(
      name: Routes.youtube,
      page: () => BlocProvider<YoutubeBloc>(
        create: (context) => sl<YoutubeBloc>(),
        child: YoutubePage(),
      ),
    ),
    GetPage(
      name: Routes.addBirthday,
      page: () => BlocProvider<BirthdayBloc>(
        create: (context) => sl<BirthdayBloc>(),
        child: AddBirthdayPage(),
      ),
    ),
  ];
}
