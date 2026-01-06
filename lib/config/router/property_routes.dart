import 'package:go_router/go_router.dart';
import 'package:real_estate_app/presentation/pages/property/detail_property_page.dart';

const String pathBase = "/property";
final propertyRoutes = [
  GoRoute(
    path: pathBase,
    name: DetailPropertyPage.name,
    builder: (context, state) => const DetailPropertyPage(),
  ),
];
