import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/config/router/app_router.dart';
import 'package:real_estate_app/config/theme/app_theme.dart';
// import 'package:real_estate_app/infraestructure/database/firebase_database.dart';
// import 'package:real_estate_app/infraestructure/database/init_database.dart';
// import 'package:real_estate_app/infraestructure/di/get_it.dart';
import 'package:real_estate_app/infraestructure/di/inyection_container.dart';
import 'package:real_estate_app/presentation/provider/property_provider.dart';
import 'package:real_estate_app/presentation/provider/theme_notifier.dart';
import 'package:real_estate_app/shared/utils/default_firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: kIsWeb ? DefaultFirebaseOptions.currentPlatform : null,
  );

  setupDependencies();
  // Primeros datos
  // final initDb = InitDatabase(getIt<FirebaseDatabaseService>());
  // await initDb.initializeFirebaseData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
      ],
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
