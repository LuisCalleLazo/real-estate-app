class PropertyEntity {
  final int id;
  final String title;
  final String description;
  final String ubication;
  final bool isFavorite;
  final String latitude;
  final String longitude;
  final double price;
  final String typePay; // Payment type: "sale", "rental", "anticretic"
  final String type; // Property type: "apartment", "house", "commercial space", "terrain"
  // "industrial warehouse", "mixed commercial-industrial space"
  final String area; // Area/Zone: "downtown", "suburban", "industrial zone",
  // "residential area", "commercial district", "countryside"
  final String
  group; // Category group: "residential", "commercial", "industrial",
  // "mixed", "land", "special"
  // residential: houses, apartments, condos, townhouses
  // commercial: offices, retail stores, restaurants, shopping centers
  // industrial: warehouses, factories, workshops, distribution centers
  // mixed: commercial-residential buildings, live-work spaces
  // land: vacant lots, development land, agricultural land
  // special: parking spaces, storage units, student housing
  final int bathrooms;
  final int parkingLots;
  final int kitchens;
  final int bedrooms;

  final List<String> photos;

  PropertyEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.ubication,
    required this.isFavorite,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.typePay,
    required this.type,
    required this.area,
    required this.group,

    required this.bathrooms,
    required this.parkingLots,
    required this.kitchens,
    required this.bedrooms,

    required this.photos,
  });
}
