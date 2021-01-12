import 'package:flutter/foundation.dart';

class Diagnosis extends ChangeNotifier {
  String _disease;

  String get getDisease => _disease;

  void update (String disease) {
    _disease = disease.toUpperCase();
    notifyListeners();
  }
}
