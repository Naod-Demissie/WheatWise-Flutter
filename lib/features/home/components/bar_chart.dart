import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSampleData {
  final String? x;
  final double y;
  final double secondSeriesYValue;

  ChartSampleData({
    this.x,
    required this.y,
    required this.secondSeriesYValue,
  });
}

class BarChart extends StatefulWidget {
  const BarChart({super.key});

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  List<ChartSampleData>? chartData;

  @override
  void initState() {
    chartData = <ChartSampleData>[
      ChartSampleData(
        x: 'Brown Rust',
        y: 84452000,
        secondSeriesYValue: 82682000,
      ),
      ChartSampleData(
        x: 'Yellow Rust',
        y: 68175000,
        secondSeriesYValue: 75315000,
      ),
      ChartSampleData(
        x: 'Mildew',
        y: 77774000,
        secondSeriesYValue: 76407000,
      ),
      ChartSampleData(
        x: 'Septoria',
        y: 50732000,
        secondSeriesYValue: 52372000,
      ),
      ChartSampleData(
        x: 'Healthy',
        y: 32093000,
        secondSeriesYValue: 35079000,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: const ChartTitle(
          text: 'Diagnosis Statistics',
          alignment: ChartAlignment.near,
          textStyle: TextStyle(
            fontFamily: 'Clash Display',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.top,
          alignment: ChartAlignment.far,
          textStyle: TextStyle(
            fontFamily: 'Clash Display',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(
            fontFamily: 'Clash Display',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        primaryYAxis: NumericAxis(
          isVisible: false,
          majorGridLines: const MajorGridLines(width: 0),
          numberFormat: NumberFormat.compact(),
          rangePadding: ChartRangePadding.auto,
        ),
        series: <BarSeries<ChartSampleData, String>>[
          BarSeries<ChartSampleData, String>(
              dataSource: chartData!,
              xValueMapper: (ChartSampleData sales, _) => sales.x as String,
              yValueMapper: (ChartSampleData sales, _) => sales.y,
              name: 'Correct'),
          BarSeries<ChartSampleData, String>(
              dataSource: chartData!,
              xValueMapper: (ChartSampleData sales, _) => sales.x as String,
              yValueMapper: (ChartSampleData sales, _) =>
                  sales.secondSeriesYValue,
              name: 'Incorrect'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}
