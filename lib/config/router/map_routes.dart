import 'package:go_router/go_router.dart';
import 'package:real_estate_app/presentation/screens/property_map_screen.dart';

const String pathBase = "/map";

final List<GoRoute> mapRoutes = [
  GoRoute(
    path: pathBase,
    name: PropertyMapScreen.name,
    builder: (context, state) => const PropertyMapScreen(),
  ),
];
