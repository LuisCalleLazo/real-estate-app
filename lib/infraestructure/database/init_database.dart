import 'package:real_estate_app/infraestructure/database/firebase_database.dart';
import 'package:real_estate_app/infraestructure/services/firebase_database_service.dart';

class InitDatabase {
  final FirebaseDatabaseService firebaseDatabaseService;
  InitDatabase(this.firebaseDatabaseService);

  Future<void> initializeFirebaseData() async {
    // Colección de comerciales inicial
    final initialCommercials = [
      {
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': 'Yape',
        'image':
            'https://startupeable.com/directorio/wp-content/uploads/2021/03/yape.png',
        'linkCommercial': 'https://www.yape.com.bo/',
      },
      {
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': 'Banco Union',
        'image':
            'https://www.datec.com.bo/wp-content/uploads/2025/04/BANCOSOL-PRINCIPAL-LOGO-CMYK2.png',
        'linkCommercial': 'https://www.bancosol.com.bo/',
      },
    ];

    await firebaseDatabaseService.initCollection(
      'commercials',
      initialCommercials,
    );

    // Colección de propiedades inicial
    final initialProperties = [
      {
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': 'Departamento en el centro',
        'description': 'Muy buena ubicación',
        'ubication': 'Centro',
        'isFavorite': false,
        'latitude': '0.0',
        'longitude': '0.0',
        'price': 120000.0,
        'typePay': 'sale',
        'type': 'apartment',
        'area': 'downtown',
        'group': 'residential',
        'bathrooms': 2,
        'parkingLots': 1,
        'kitchens': 1,
        'bedrooms': 3,
        'photos': [
          'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800',
          'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
          'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
        ],
      },
    ];

    await firebaseDatabaseService.initCollection(
      'properties',
      initialProperties,
    );
  }
}
