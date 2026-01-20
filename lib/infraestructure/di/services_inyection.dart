import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:real_estate_app/infraestructure/di/get_it.dart';
import 'package:real_estate_app/infraestructure/services/cloudinary_service.dart';

void setupServices() {
  getIt.registerLazySingleton(
    () => CloudinaryService(
      cloudName: dotenv.env['CLOUDINARY_NAME']!,
      uploadPreset: dotenv.env['CLOUDINARY_UPLOAD_PRESET']!,
    ),
  );
}
