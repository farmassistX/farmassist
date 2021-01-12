import 'package:flutter/foundation.dart';

class Diagnosis extends ChangeNotifier {
  String _disease;
  String _confidence;

  String get disease => _disease;
  String get confidence => _confidence;

  void update(String disease, String confidence) {
    _disease = disease.toUpperCase();
    _confidence = confidence;
    notifyListeners();
  }
}
