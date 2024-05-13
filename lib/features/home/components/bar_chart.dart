import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_bloc.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_state.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

class ChartSampleData {
  final String x;
  final double y;
  final double secondSeriesYValue;

  ChartSampleData({
    required this.x,
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
  List<ChartSampleData> chartData = [];

  @override
  void initState() {
    super.initState();
  }

  List<ChartSampleData> _getChartData(
      Map<String, Map<String, int>> diagnosisStatistics) {
    List<ChartSampleData> chartData = [];
    List<String> diseaseList = [
      'Healthy',
      'Septoria',
      'Brown Rust',
      'Yellow Rust',
      'Mildew'
    ];

    for (int i = 0; i < diseaseList.length; i++) {
      String disease = diseaseList[i];
      int correctCount = diagnosisStatistics['Correct']?[disease] ?? 0;
      int incorrectCount = diagnosisStatistics['Incorrect']?[disease] ?? 0;

      chartData.add(ChartSampleData(
          x: disease,
          y: correctCount.toDouble(),
          secondSeriesYValue: incorrectCount.toDouble()));
    }
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiagnosisStatisticsBloc, DiagnosisStatisticsState>(
      builder: (context, diagnosisStatisticsState) {
        if (diagnosisStatisticsState is DiagnosisStatisticsSuccessState) {
          chartData =
              _getChartData(diagnosisStatisticsState.diagnosisStatistics);
          return _buildSfCartesianChart(context);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  SfCartesianChart _buildSfCartesianChart(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(enable: true),
      plotAreaBorderColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: 'Diagnosis Statistics',
        alignment: ChartAlignment.near,
        textStyle: TextStyle(
          fontFamily: 'Clash Display',
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: BlocProvider.of<ThemeBloc>(context).state.textColor,
        ),
      ),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.top,
        alignment: ChartAlignment.far,
        textStyle: TextStyle(
          fontFamily: 'Clash Display',
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: BlocProvider.of<ThemeBloc>(context).state.textColor,
        ),
      ),
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(
          fontFamily: 'Clash Display',
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: BlocProvider.of<ThemeBloc>(context).state.textColor,
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
          dataSource: chartData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          name: 'Correct',
        ),
        BarSeries<ChartSampleData, String>(
            dataSource: chartData,
            xValueMapper: (ChartSampleData data, _) => data.x,
            yValueMapper: (ChartSampleData data, _) => data.secondSeriesYValue,
            name: 'Incorrect'),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
