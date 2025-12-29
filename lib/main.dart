import 'package:flutter/material.dart';
import 'package:real_estate_app/config/router/app_router.dart';
import 'package:real_estate_app/config/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Inmo',
      theme: AppTheme().getLightTheme(),
      routerConfig: appRouter,
    );
  }
}
