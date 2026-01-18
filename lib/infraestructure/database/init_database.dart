import 'package:real_estate_app/infraestructure/database/firebase_database.dart';
import 'package:real_estate_app/infraestructure/services/firebase_database_service.dart';

class InitDatabase {
  void initializeFirebaseData() async {
  //   // Colección de comerciales inicial
  //   final initialCommercials = [
  //     {
  //       'id': 1,
  //       'title': 'Oficina Central',
  //       'image': 'https://example.com/img1.jpg',
  //       'linkCommercial': 'https://example.com/oficina-central',
  //     },
  //     {
  //       'id': 2,
  //       'title': 'Banco Union',
  //       'image': 'https://example.com/img2.jpg',
  //       'linkCommercial': 'https://example.com/local-comercial',
  //     },
  //   ];

    // await firebaseDatabaseService.initCollection(
    //   'commercials',
    //   initialCommercials,
    // );

    // Colección de propiedades inicial
    final initialProperties = [
      {
        'id': 1,
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
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
        ],
      },
    ];

    await firebaseDatabaseService.initCollection(
      'properties',
      initialProperties,
    );
  }
}
