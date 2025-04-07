// import 'package:flutter/material.dart';
// import '../../modulos.dart';

// class AppRouter {
//   static const ROUTE_MAIN = "/main";
//   static const ROUTE_HOME = "/home";
//   static const ROUTE_REGISTER = "/register";
//   static const ROUTE_CRIAR_ESCALA = "/register";

//   static const ROUTE_CRIARDEVOCIONAL = "/criarDevocional";
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case ROUTE_MAIN:
//         return MaterialPageRoute(builder: (_) => MainWidget());
//       case ROUTE_HOME:
//         return MaterialPageRoute(builder: (_) => Home());
//       case ROUTE_CRIARDEVOCIONAL:
//         return MaterialPageRoute(builder: (_) => AdicionarDevocional());
//       case ROUTE_CRIAR_ESCALA:
//         return MaterialPageRoute(
//             builder: (context) => BlocProvider(
//                   create: (context) => getIt<EscalaCubit>(),
//                   child: CriarEscalas(),
//                 ));
//       default:
//         return MaterialPageRoute(
//             builder: (_) => Scaffold(body: Center(child: Text("No route"))));
//     }
//   }
// }
