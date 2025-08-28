import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/blocs/theme/theme_bloc.dart';
import 'core/theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/cats_screen.dart';
import 'screens/dogs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(prefs)..add(ThemeLoaded()),
        ),
      ],
      child: const KittyPawsApp(),
    ),
  );
}

class KittyPawsApp extends StatelessWidget {
  const KittyPawsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDarkMode = state is ThemeLoadedState ? state.isDarkMode : false;
        
        return MaterialApp(
          title: 'KittyPaws',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/cats': (context) => const CatsScreen(),
            '/dogs': (context) => const DogsScreen(),
          },
        );
      },
    );
  }
}
