import 'package:farmassist/data/IoT/telemetry_data_repository.dart';
import 'package:farmassist/ui/IoT/telemetry_data_card_item.dart';
import 'package:farmassist/utils/fixed_sized_queue.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TelemetryDataChart extends StatelessWidget {
  TelemetryDataChart({Key key, @required this.numData, @required this.cardItem})
      : spots = LineChartSpots(numData),
        bottomTitles = FixedSizedQueue(numData),
        xIndexes = Iterable<int>.generate(numData).toList(),
        super(key: key);

  final int numData;
  final LineChartSpots spots;
  final FixedSizedQueue<String> bottomTitles;
  final xIndexes;
  final TelemetryDataCardItem cardItem;

  @override
  Widget build(BuildContext context) {
    TelemetryData telemetryData = context.watch<TelemetryData>();

    if (telemetryData == null) {
      return Container();
    } else {
      spots.add(telemetryData.value);
      bottomTitles.add(DateFormat.ms().format(telemetryData.timestamp));
    }

    return LineChart(
      LineChartData(
        lineTouchData: _lineTouchData(),
        titlesData: _titlesData(),
        lineBarsData: _lineBarsData(spots),
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            _horizontalLine(cardItem.lowerThreshold),
            _horizontalLine(cardItem.upperThreshold),
          ],
        ),
        clipData: FlClipData.all(),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        // Decrements 1.0 by 0.15 to avoid points be blocked by the drawing region.
        minX: 0.85,
        // Increments by 0.15 to avoid points be blocked by the drawing region.
        maxX: numData.toDouble() + 0.15,
        maxY: cardItem.upperBoundary,
        minY: cardItem.lowerBoundary,
      ),
    );
  }

  List<LineChartBarData> _lineBarsData(LineChartSpots spots) {
    return [
      LineChartBarData(
        spots: spots.toList(),
        showingIndicators: xIndexes,
        isCurved: true,
        curveSmoothness: 0,
        colors: const [Colors.white],
        barWidth: 4,
        isStrokeCapRound: true,
        shadow: const Shadow(
          blurRadius: 10,
          color: Colors.black,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors: [Colors.transparent],
        ),
        dotData: FlDotData(
          show: true,
          getDotPainter: (_, __, ___, ____) {
            return FlDotCirclePainter(
              radius: 5,
              color: Colors.red,
              strokeWidth: 2,
              strokeColor: Colors.black,
            );
          },
        ),
      ),
    ];
  }

  LineTouchData _lineTouchData() {
    return LineTouchData(
      enabled: true,
      handleBuiltInTouches: true,
      getTouchedSpotIndicator: (_, spotIndexes) {
        return spotIndexes.map((_) {
          return TouchedSpotIndicatorData(
            FlLine(color: Colors.pink),
            null,
          );
        }).toList();
      },
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.pink,
        tooltipRoundedRadius: 8,
        getTooltipItems: (lineBarsSpot) {
          return lineBarsSpot.map((lineBarSpot) {
            return LineTooltipItem(
              lineBarSpot.y.toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          }).toList();
        },
      ),
    );
  }

  FlTitlesData _titlesData() {
    return FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 10,
        margin: 8,
        getTitles: (x) {
          if (x.ceil() <= bottomTitles.length) {
            return bottomTitles[x.ceil() - 1];
          } else {
            return '';
          }
        },
        getTextStyles: (value) {
          return const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          );
        },
      ),
      leftTitles: SideTitles(
        showTitles: false,
        reservedSize: 0,
      ),
    );
  }

  HorizontalLine _horizontalLine(double threshold) {
    return HorizontalLine(
      y: threshold,
      color: Colors.red.withOpacity(0.8),
      strokeWidth: 3,
      dashArray: [20, 2],
      label: HorizontalLineLabel(
        show: true,
        alignment: Alignment.center,
        style: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.pink,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
