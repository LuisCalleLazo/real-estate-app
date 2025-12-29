import 'package:go_router/go_router.dart';
import 'package:real_estate_app/presentation/pages/auth/login_auth_page.dart';
import 'package:real_estate_app/presentation/pages/auth/register_auth_page.dart';

const String pathBase = "/auth";

final List<GoRoute> authRoutes = [
  GoRoute(
    path: '$pathBase/login',
    name: LoginAuthPage.name,
    builder: (context, state) => const LoginAuthPage(),
  ),
  GoRoute(
    path: '$pathBase/register',
    name: RegisterAuthPage.name,
    builder: (context, state) => const RegisterAuthPage(),
  ),
];
