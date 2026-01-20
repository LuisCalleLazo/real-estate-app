import 'package:go_router/go_router.dart';
import 'package:real_estate_app/presentation/pages/property/detail_property_page.dart';
import 'package:real_estate_app/presentation/pages/property/images_property_page.dart';

const String pathBase = "/property";
final propertyRoutes = [
  GoRoute(
    path: pathBase,
    name: DetailPropertyPage.name,
    builder: (context, state) => const DetailPropertyPage(),
  ),
  GoRoute(
    path: '$pathBase/images',
    name: ImagesPropertyPage.name,
    builder: (context, state) {
      final images = state.extra as List<String>;
      return ImagesPropertyPage(images: images);
    },
  ),
];
