import 'dart:ui';

class TelemetryDataCardItem {
  TelemetryDataCardItem({
    this.title,
    this.description,
    this.unit,
    this.imagePath,
    this.color1,
    this.color2,
    this.data,
    this.lowerBoundary,
    this.upperBoundary,
    this.lowerThreshold,
    this.upperThreshold,
  });

  final String title;
  final String description;
  final String unit;
  final String imagePath;
  final Color color1;
  final Color color2;
  final String data;
  final double lowerBoundary;
  final double upperBoundary;
  final double lowerThreshold;
  final double upperThreshold;

  static List<TelemetryDataCardItem> cardItems = [
    TelemetryDataCardItem(
      title: 'Air Humidity',
      description: 'Relative percentage of water vapour present in air',
      unit: '%',
      imagePath: 'assets/images/air_humidity.png',
      color1: const Color(0xFF6F56E8),
      color2: const Color(0xFF79D1FB),
      data: "humidity",
      lowerBoundary: 40.0,
      upperBoundary: 80.0,
      lowerThreshold: 50.0,
      upperThreshold: 70.0,
    ),
    TelemetryDataCardItem(
      title: 'Air Temperature',
      description: 'Weather parameter that measures how hot or cold the air is',
      unit: '°C',
      imagePath: 'assets/images/air_temperature.png',
      color1: const Color(0xFF006400),
      color2: const Color(0xFF1FDF39),
      data: "temperature",
      lowerBoundary: 15.0,
      upperBoundary: 35.0,
      lowerThreshold: 18.0,
      upperThreshold: 28.0,
    ),
    TelemetryDataCardItem(
      title: 'Soil Moisture',
      description: 'Percentage of volumetric water content in soil',
      unit: '%',
      imagePath: 'assets/images/soil_moisture.png',
      color1: const Color(0xFF800000),
      color2: const Color(0xFFD2691E),
      data: "moisture",
      lowerBoundary: 30.0,
      upperBoundary: 60.0,
      lowerThreshold: 40.0,
      upperThreshold: 50.0,
    ),
    TelemetryDataCardItem(
      title: 'Soil pH',
      description: 'Measure of acidity or alkalinity of soil',
      unit: 'pH',
      imagePath: 'assets/images/soil_pH.png',
      color1: const Color(0xFFFF3F34),
      color2: const Color(0xFFFFA334),
      data: "pH",
      lowerBoundary: 4.0,
      upperBoundary: 8.5,
      lowerThreshold: 5.5,
      upperThreshold: 7.5,
    ),
    TelemetryDataCardItem(
      title: 'Soil Salinity',
      description: 'Measure of salt content of soil in milliSiemens per cm',
      unit: 'mS/cm',
      imagePath: 'assets/images/soil_salinity.png',
      color1: const Color(0xFF9700CB),
      color2: const Color(0xFFF410D9),
      data: "salinity",
      lowerBoundary: -2.0,
      upperBoundary: 4.0,
      lowerThreshold: 0.0,
      upperThreshold: 2.5,
    ),
  ];
}
