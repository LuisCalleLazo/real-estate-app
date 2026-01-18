import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/config/router/app_router.dart';
import 'package:real_estate_app/config/theme/app_theme.dart';
import 'package:real_estate_app/infraestructure/di/inyection_container.dart';
import 'package:real_estate_app/presentation/provider/theme_notifier.dart';
import 'package:real_estate_app/shared/utils/default_firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (e.toString().contains('duplicate-app')) {
      // Firebase ya está inicializado, continuar normalmente
      print('⚠️ Firebase already initialized, continuing...');
    } else {
      // Otro error, re-lanzar
      rethrow;
    }
  }

  setupDependencies();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeNotifier())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();

    return MaterialApp.router(
      title: 'InmoBol',
      debugShowCheckedModeBanner: false,

      theme: AppTheme().getLightTheme(),
      darkTheme: AppTheme().getDarkTheme(),
      themeMode: themeNotifier.themeMode,

      routerConfig: appRouter,
    );
  }
}
