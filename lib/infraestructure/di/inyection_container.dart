import 'package:real_estate_app/infraestructure/di/database_inyection.dart';
import 'package:real_estate_app/infraestructure/di/services_inyection.dart';

void setupDependencies() {
  setupDatabase();
  setupServices();
}
