import 'dart:io';

abstract class PropertyRepository {
  Future<void> createProperty(
    String title,
    String description,
    String location,
    double price,
    String type,
    String category,
    String typePayment,
    String zone,
    int bedrooms,
    int bathrooms,
    int parkingLots,
    int kitchens,
    List<File> images,
  );
}
