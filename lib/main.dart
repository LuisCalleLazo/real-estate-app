import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/config/router/app_router.dart';
import 'package:real_estate_app/config/theme/app_theme.dart';
import 'package:real_estate_app/presentation/provider/theme_notifier.dart';

void main() {
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
