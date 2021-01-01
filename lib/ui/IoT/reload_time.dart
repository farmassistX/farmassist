import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class ReloadTime extends ChangeNotifier {
  String _reloadTime;

  String get reloadTime => _reloadTime;

  void update() {
    _reloadTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
    notifyListeners();
  }
}
