class TemperatureConvert {
  static double fahrenheitToCelsius(double temperature) {
    return (temperature - 32) * (5 / 9);
  }

  static double celsiusFahrenheit(double temperature) {
    return (temperature * (5 / 9)) + 32;
  }

  static double kelvinToCelsius(double temperature) {
    return (temperature - 273.15);
  }

  static double celsiusToKevlin(double temperature) {
    return (temperature + 273.15);
  }
}
