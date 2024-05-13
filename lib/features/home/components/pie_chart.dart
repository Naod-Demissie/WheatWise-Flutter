import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_bloc.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_state.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

class ChartSampleData {
  final String x;
  final double y;
  final String text;

  ChartSampleData({
    required this.x,
    required this.y,
    required this.text,
  });
}

class PieRadius extends StatefulWidget {
  const PieRadius({super.key});

  @override
  State<PieRadius> createState() => _PieRadiusState();
}

class _PieRadiusState extends State<PieRadius> {
  List<ChartSampleData> chartData = [];

  @override
  void initState() {
    super.initState();
  }

  List<ChartSampleData> _getRadiusPieSeries(
      Map<String, Map<String, int>> diagnosisStatistics) {
    List<ChartSampleData> chartData = [];

    List<String> chartSampleDataText = [
      '50.7%',
      '59.6%',
      '72.5%',
      '85.8%',
      '93.5%'
    ];

    List<String> diseaseList = [
      'Healthy',
      'Septoria',
      'Brown Rust',
      'Yellow Rust',
      'Mildew'
    ];

    for (int i = 0; i < diseaseList.length; i++) {
      String disease = diseaseList[i];
      int count = diagnosisStatistics['total']![disease] ?? 0;
      chartData.add(ChartSampleData(
          x: disease, y: count.toDouble(), text: chartSampleDataText[i]));
    }

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiagnosisStatisticsBloc, DiagnosisStatisticsState>(
      builder: (context, diagnosisStatisticsState) {
        if (diagnosisStatisticsState is DiagnosisStatisticsSuccessState) {
          chartData =
              _getRadiusPieSeries(diagnosisStatisticsState.diagnosisStatistics);
          return _buildRadiusPieChart(context);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  SfCircularChart _buildRadiusPieChart(BuildContext context) {
    return SfCircularChart(
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
      series: <PieSeries<ChartSampleData, String>>[
        PieSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointRadiusMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
            labelPosition: ChartDataLabelPosition.outside,
          ),
        ),
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.left,
        itemPadding: 8.0,
        textStyle: TextStyle(
          fontFamily: 'Clash Display',
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: BlocProvider.of<ThemeBloc>(context).state.textColor,
        ),
      ),
    );
  }
}
