import 'package:farmassist/utils/fixed_sized_queue.dart';
import 'package:fl_chart/fl_chart.dart';

/// A wrapper of [FixedSizedQueue] that is used to store coordinates
/// of points in a real-time line chart plot.
class LineChartSpots {
  LineChartSpots(int size) {
    _spots = FixedSizedQueue(size);
  }

  FixedSizedQueue<FlSpot> _spots;
  double _count = 1;

  /// Adds value of y-coordinate produced at a particular point in time.
  void add(String value) {
    double y = double.parse(value);

    /// Adds and increments x-coordinate if its size is less then the maximum size.
    if (_count <= _spots.size) {
      _spots.add(FlSpot(_count++, y));
    }

    /// If the maximum size is reached,
    else {
      _spots.add(FlSpot(_count, y));

      /// Decrements every x-coordinate as the oldest point is removed and the
      /// latest point is added. This produces an effect of animating a
      /// real-time chart.
      _spots.queue = _spots.queue.map((s) => FlSpot(s.x - 1, s.y)).toList();
    }
  }

  List<FlSpot> toList() => _spots.toList();
}
