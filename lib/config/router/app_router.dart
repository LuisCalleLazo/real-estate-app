import 'package:go_router/go_router.dart';
import 'package:real_estate_app/config/router/auth_routes.dart';
import 'package:real_estate_app/presentation/pages/home_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ...authRoutes,
    // ...adminRoutes,
    GoRoute(
      path: '/',
      name: HomePage.name,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
