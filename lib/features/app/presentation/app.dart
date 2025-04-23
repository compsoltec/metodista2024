import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../events/presentation/bloc/event_bloc.dart';
import '../home/home.dart';
import 'presentation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => sl<HomeBloc>()..add(LoadHomeData()),
        ),
        BlocProvider<EventBloc>(
          create: (context) => sl<EventBloc>(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Igreja Metodista',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        locale: const Locale('pt', 'BR'),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.light(
            primary: AppColors.primaryColor,
            secondary: AppColors.secondaryColor,
            tertiary: AppColors.accentColor,
            surface: AppColors.cardColor,
          ),
          textTheme: GoogleFonts.montserratTextTheme(
            ThemeData.light().textTheme.copyWith(
                  titleLarge: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  titleMedium: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  bodyLarge: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.dark(
            primary: AppColors.primaryColor,
            secondary: AppColors.secondaryColor,
            tertiary: AppColors.accentColor,
            surface: AppColors.darkGray,
          ),
          textTheme: GoogleFonts.montserratTextTheme(
            ThemeData.dark().textTheme.copyWith(
                  titleLarge: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  titleMedium: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                  bodyLarge: const TextStyle(
                    fontSize: 16,
                    color: AppColors.lightGray,
                  ),
                ),
          ),
        ),
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
