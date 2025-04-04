import '../../../../core/core.dart';
import '../../../events/events.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;
  static const events_admin = Routes.addEvent;

  static final routes = [
    GetPage(
      name: Routes.addEvent,
      page: () => BlocProvider(
        create: (context) => sl<EventBloc>(),
        child: const AddEventPage(),
      ),
    ),
  ];
}
