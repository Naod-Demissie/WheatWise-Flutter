import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSampleData {
  final String x;
  final double y;
  final String text;

  ChartSampleData({required this.x, required this.y, required this.text});
}

class PieRadius extends StatelessWidget {
  const PieRadius({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: _buildRadiusPieChart(),
    );
  }

  SfCircularChart _buildRadiusPieChart() {
    return SfCircularChart(
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
      series: _getRadiusPieSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
      legend: const Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.left,
        itemPadding: 8.0,
        textStyle: TextStyle(
          fontFamily: 'Clash Display',
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }

  List<PieSeries<ChartSampleData, String>> _getRadiusPieSeries() {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          ChartSampleData(x: 'Healthy', y: 551500, text: '53.7%'),
          ChartSampleData(x: 'Septoria', y: 312685, text: '59.6%'),
          ChartSampleData(x: 'Brown Rust', y: 350000, text: '72.5%'),
          ChartSampleData(x: 'Yellow Rust', y: 301000, text: '85.8%'),
          ChartSampleData(x: 'Mildew', y: 300000, text: '90.5%'),
        ],
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.y,
        pointRadiusMapper: (ChartSampleData data, _) => data.text,
        dataLabelSettings: const DataLabelSettings(
          isVisible: false,
          labelPosition: ChartDataLabelPosition.outside,
        ),
      ),
    ];
  }
}
