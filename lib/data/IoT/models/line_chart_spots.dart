import 'package:farmassist/utils/fixed_sized_queue.dart';
import 'package:fl_chart/fl_chart.dart';

/// A wrapper of [FixedSizedQueue] that is used to store coordinates
/// of points in a real-time line chart plot.
class LineChartSpots {
  LineChartSpots(int size) {
    _spots = FixedSizedQueue(size);
  }

  FixedSizedQueue<FlSpot> _spots;

  /// Adds value of y-coordinate produced at a particular point in time.
  void add(String value) {
    double y = double.parse(value);
    bool pushForward = false;

    /// Sets [pushForward] flag to true if the maximum size is reached.
    if (_spots.length == _spots.size) pushForward = true;

    /// Adds x-coordinate.
    _spots.add(FlSpot((_spots.length + 1).toDouble(), y));

    /// Push every spot in the queue 1 index forwards as the oldest point
    /// is removed and the latest point is added. This produces an effect
    /// of animating a real-time chart.
    if (pushForward) {
      _spots.queue = _spots.queue.map((s) => FlSpot(s.x - 1, s.y)).toList();
    }
  }

  int get length => _spots.length;
  List<FlSpot> toList() => _spots.toList();
}
