class RateModel {
  late double _rate;
  late int _count;

  RateModel(this._rate, this._count);

  get Rate {
    return _rate;
  }

  get Count {
    return _count;
  }

  set rate(double rate) {
    _rate = rate;
  }

  set count(int count) {
    _count = count;
  }

  RateModel.fromJSON(json) {
    _rate = json["rate"].toDouble() ?? 0.0;
    _count = json["count"] ?? 0;
  }
}
