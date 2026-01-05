import 'package:flutter/material.dart';

class MapThemeExtension extends ThemeExtension<MapThemeExtension> {
  final String tileUrl;
  final Color markerColor;
  final Color selectedMarkerColor;
  final Color poiColor;

  const MapThemeExtension({
    required this.tileUrl,
    required this.markerColor,
    required this.selectedMarkerColor,
    required this.poiColor,
  });

  @override
  ThemeExtension<MapThemeExtension> copyWith({
    String? tileUrl,
    Color? markerColor,
    Color? selectedMarkerColor,
    Color? poiColor,
  }) {
    return MapThemeExtension(
      tileUrl: tileUrl ?? this.tileUrl,
      markerColor: markerColor ?? this.markerColor,
      selectedMarkerColor: selectedMarkerColor ?? this.selectedMarkerColor,
      poiColor: poiColor ?? this.poiColor,
    );
  }

  @override
  ThemeExtension<MapThemeExtension> lerp(
    ThemeExtension<MapThemeExtension>? other,
    double t,
  ) {
    if (other is! MapThemeExtension) {
      return this;
    }
    return MapThemeExtension(
      tileUrl: tileUrl,
      markerColor: Color.lerp(markerColor, other.markerColor, t)!,
      selectedMarkerColor: Color.lerp(
        selectedMarkerColor,
        other.selectedMarkerColor,
        t,
      )!,
      poiColor: Color.lerp(poiColor, other.poiColor, t)!,
    );
  }
}
