import 'package:go_router/go_router.dart';
import 'package:real_estate_app/presentation/pages/app/home_page.dart';

const String pathBase = "/home";
final homeRoutes = [
  GoRoute(
    path: pathBase,
    name: HomePage.name,
    builder: (context, state) => const HomePage(),
  ),
];
