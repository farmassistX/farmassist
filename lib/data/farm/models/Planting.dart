class Planting {
  String _name;
  int _noOfPlants;
  String _date;
  String _estimatedHarvest;
  String _location;
  String _fertilizers;
  String _seedsUsed;

  Planting(this._name, this._noOfPlants, this._date, this._estimatedHarvest,
      this._location, this._fertilizers, this._seedsUsed);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get seedsUsed => _seedsUsed;

  set seedsUsed(String value) {
    _seedsUsed = value;
  }

  String get fertilizers => _fertilizers;

  set fertilizers(String value) {
    _fertilizers = value;
  }

  String get location => _location;

  set location(String value) {
    _location = value;
  }

  String get estimatedHarvest => _estimatedHarvest;

  set estimatedHarvest(String value) {
    _estimatedHarvest = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  int get noOfPlants => _noOfPlants;

  set noOfPlants(int value) {
    _noOfPlants = value;
  }
}
