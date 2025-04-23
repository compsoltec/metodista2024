import '../../../../core/core.dart';
import '../../../features.dart';
import '../../events/presentation/bloc/event_bloc.dart';
import '../../events/presentation/pages/create_event.dart';

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
  ];
}
