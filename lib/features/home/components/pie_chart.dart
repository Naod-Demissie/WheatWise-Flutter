// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:wheatwise/features/home/bloc/diagnosis_statistics_bloc.dart';
// import 'package:wheatwise/features/home/bloc/diagnosis_statistics_event.dart';
// import 'package:wheatwise/features/home/bloc/diagnosis_statistics_state.dart';
// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

// class ChartSampleData {
//   final String x;
//   final double y;
//   final String text;

//   ChartSampleData({
//     required this.x,
//     required this.y,
//     required this.text,
//   });
// }

// class PieRadius extends StatelessWidget {
//   const PieRadius({super.key});

//   List<ChartSampleData> _getRadiusPieSeries(
//       Map<String, Map<String, int>> diagnosisStatistics) {
//     List<ChartSampleData> chartData = [];
//     List<String> chartSampleDataText = [
//       '50.7%',
//       '59.6%',
//       '72.5%',
//       '85.8%',
//       '93.5%'
//     ];

//     List<String> diseaseList = [
//       'Healthy',
//       'Septoria',
//       'Brown Rust',
//       'Yellow Rust',
//       'Mildew'
//     ];

//     for (int i = 0; i < diseaseList.length; i++) {
//       String disease = diseaseList[i];
//       int count = diagnosisStatistics['total']![disease] ?? 0;
//       chartData.add(ChartSampleData(
//           x: disease, y: count.toDouble(), text: chartSampleDataText[i]));
//     }
//     return chartData;
//   }

//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<DiagnosisStatisticsBloc>(context)
//         .add(const LoadDiagnosisStatisticsEvent());
//     return BlocBuilder<DiagnosisStatisticsBloc, DiagnosisStatisticsState>(
//       builder: (context, diagnosisStatisticsState) {
//         if (diagnosisStatisticsState is DiagnosisStatisticsSuccessState) {
//           final List<ChartSampleData> chartData =
//               _getRadiusPieSeries(diagnosisStatisticsState.diagnosisStatistics);
//           return _buildRadiusPieChart(context, chartData);
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }

//   SfCircularChart _buildRadiusPieChart(
//       BuildContext context, List<ChartSampleData> chartData) {
//     return SfCircularChart(
//       title: ChartTitle(
//         text: 'Diagnosis Statistics',
//         alignment: ChartAlignment.near,
//         textStyle: TextStyle(
//           fontFamily: 'Clash Display',
//           fontWeight: FontWeight.w600,
//           fontSize: 18,
//           color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//         ),
//       ),
//       series: <PieSeries<ChartSampleData, String>>[
//         PieSeries<ChartSampleData, String>(
//           dataSource: chartData,
//           xValueMapper: (ChartSampleData data, _) => data.x,
//           yValueMapper: (ChartSampleData data, _) => data.y,
//           pointRadiusMapper: (ChartSampleData data, _) => data.text,
//           dataLabelSettings: const DataLabelSettings(
//             isVisible: false,
//             labelPosition: ChartDataLabelPosition.outside,
//           ),
//         ),
//       ],
//       tooltipBehavior: TooltipBehavior(enable: true),
//       legend: Legend(
//         isVisible: true,
//         overflowMode: LegendItemOverflowMode.wrap,
//         position: LegendPosition.left,
//         itemPadding: 8.0,
//         textStyle: TextStyle(
//           fontFamily: 'Clash Display',
//           fontWeight: FontWeight.w400,
//           fontSize: 15,
//           color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_bloc.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_event.dart';
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

// class PieRadius extends StatefulWidget {
//   const PieRadius({super.key});

//   @override
//   State<PieRadius> createState() => _PieRadiusState();
// }

// class _PieRadiusState extends State<PieRadius> {
//   List<ChartSampleData> chartData = [];

//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<DiagnosisStatisticsBloc>(context)
//         .add(const LoadDiagnosisStatisticsEvent());
//   }

//   List<PieSeries<ChartSampleData, String>> _getRadiusPieSeries(
//       Map<String, Map<String, int>> diagnosisStatistics) {
//     List<ChartSampleData> chartData = [];

//     List<String> chartSampleDataText = [
//       '50.7%',
//       '59.6%',
//       '72.5%',
//       '85.8%',
//       '93.5%'
//     ];

//     List<String> diseaseList = [
//       'Healthy',
//       'Septoria',
//       'Brown Rust',
//       'Yellow Rust',
//       'Mildew'
//     ];

//     for (int i = 0; i < diseaseList.length; i++) {
//       String disease = diseaseList[i];
//       int count = diagnosisStatistics['total']![disease] ?? 0;
//       chartData.add(ChartSampleData(
//           x: disease, y: count.toDouble(), text: chartSampleDataText[i]));
//     }

//     return <PieSeries<ChartSampleData, String>>[
//       PieSeries<ChartSampleData, String>(
//         dataSource: chartData,
//         xValueMapper: (ChartSampleData data, _) => data.x,
//         yValueMapper: (ChartSampleData data, _) => data.y,
//         pointRadiusMapper: (ChartSampleData data, _) => data.text,
//         dataLabelSettings: const DataLabelSettings(
//           isVisible: false,
//           labelPosition: ChartDataLabelPosition.outside,
//         ),
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DiagnosisStatisticsBloc, DiagnosisStatisticsState>(
//       builder: (context, diagnosisStatisticsState) {
//         if (diagnosisStatisticsState is DiagnosisStatisticsSuccessState) {
//           return _buildRadiusPieChart(
//               context, diagnosisStatisticsState.diagnosisStatistics);
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }

//   SfCircularChart _buildRadiusPieChart(
//       BuildContext context, Map<String, Map<String, int>> diagnosisStatistics) {
//     return SfCircularChart(
//       title: ChartTitle(
//         text: 'Diagnosis Statistics',
//         alignment: ChartAlignment.near,
//         textStyle: TextStyle(
//           fontFamily: 'Clash Display',
//           fontWeight: FontWeight.w600,
//           fontSize: 18,
//           color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//         ),
//       ),
//       series: _getRadiusPieSeries(diagnosisStatistics),
//       tooltipBehavior: TooltipBehavior(enable: true),
//       legend: Legend(
//         isVisible: true,
//         overflowMode: LegendItemOverflowMode.wrap,
//         position: LegendPosition.left,
//         itemPadding: 8.0,
//         textStyle: TextStyle(
//           fontFamily: 'Clash Display',
//           fontWeight: FontWeight.w400,
//           fontSize: 15,
//           color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:wheatwise/features/home/bloc/diagnosis_statistics_bloc.dart';
// import 'package:wheatwise/features/home/bloc/diagnosis_statistics_event.dart';
// import 'package:wheatwise/features/home/bloc/diagnosis_statistics_state.dart';
// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

// class ChartSampleData {
//   final String x;
//   final double y;
//   final String text;

//   ChartSampleData({
//     required this.x,
//     required this.y,
//     required this.text,
//   });
// }

// class PieRadius extends StatefulWidget {
//   const PieRadius({super.key});

//   @override
//   State<PieRadius> createState() => _PieRadiusState();
// }

// class _PieRadiusState extends State<PieRadius> {
//   List<PieSeries<ChartSampleData, String>> _getRadiusPieSeries(
//       Map<String, Map<String, int>> diagnosisStatistics) {
//     List<String> chartSampleDataText = [
//       '50.7%',
//       '59.6%',
//       '72.5%',
//       '85.8%',
//       '93.5%'
//     ];

//     List<ChartSampleData> data = [];
//     List<String> diseaseList = [
//       'Healthy',
//       'Septoria',
//       'Brown Rust',
//       'Yellow Rust',
//       'Mildew'
//     ];

//     for (int i = 0; i < diseaseList.length; i++) {
//       String disease = diseaseList[i];
//       int count = diagnosisStatistics['total']![disease] ?? 0;
//       data.add(ChartSampleData(
//           x: disease, y: count.toDouble(), text: chartSampleDataText[i]));
//     }

//     return <PieSeries<ChartSampleData, String>>[
//       PieSeries<ChartSampleData, String>(
//         dataSource: data,
//         xValueMapper: (ChartSampleData data, _) => data.x,
//         yValueMapper: (ChartSampleData data, _) => data.y,
//         pointRadiusMapper: (ChartSampleData data, _) => data.text,
//         dataLabelSettings: const DataLabelSettings(
//           isVisible: false,
//           labelPosition: ChartDataLabelPosition.outside,
//         ),
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<DiagnosisStatisticsBloc>(context)
//         .add(const LoadDiagnosisStatisticsEvent());
//     return BlocBuilder<DiagnosisStatisticsBloc, DiagnosisStatisticsState>(
//       builder: (context, state) {
//         if (state is DiagnosisStatisticsSuccessState) {
//           return _buildRadiusPieChart(context, state.diagnosisStatistics);
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }

//   SfCircularChart _buildRadiusPieChart(
//       BuildContext context, Map<String, Map<String, int>> diagnosisStatistics) {
//     return SfCircularChart(
//       title: ChartTitle(
//         text: 'Diagnosis Statistics',
//         alignment: ChartAlignment.near,
//         textStyle: TextStyle(
//           fontFamily: 'Clash Display',
//           fontWeight: FontWeight.w600,
//           fontSize: 18,
//           color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//         ),
//       ),
//       series: _getRadiusPieSeries(diagnosisStatistics),
//       tooltipBehavior: TooltipBehavior(enable: true),
//       legend: Legend(
//         isVisible: true,
//         overflowMode: LegendItemOverflowMode.wrap,
//         position: LegendPosition.left,
//         itemPadding: 8.0,
//         textStyle: TextStyle(
//           fontFamily: 'Clash Display',
//           fontWeight: FontWeight.w400,
//           fontSize: 15,
//           color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:wheatwise/features/home/bloc/diagnosis_statistics_bloc.dart';
// import 'package:wheatwise/features/home/bloc/diagnosis_statistics_event.dart';
// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

// class ChartSampleData {
//   final String x;
//   final double y;
//   final String text;

//   ChartSampleData({required this.x, required this.y, required this.text});
// }

// class PieRadius extends StatelessWidget {
//   const PieRadius({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return _buildRadiusPieChart(context);
//   }

//   SfCircularChart _buildRadiusPieChart(BuildContext context) {
//     return SfCircularChart(
//       title: ChartTitle(
//         text: 'Diagnosis Statistics',
//         alignment: ChartAlignment.near,
//         textStyle: TextStyle(
//           fontFamily: 'Clash Display',
//           fontWeight: FontWeight.w600,
//           fontSize: 18,
//           color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//         ),
//       ),
//       series: _getRadiusPieSeries(),
//       tooltipBehavior: TooltipBehavior(enable: true),
//       legend: Legend(
//         isVisible: true,
//         overflowMode: LegendItemOverflowMode.wrap,
//         position: LegendPosition.left,
//         itemPadding: 8.0,
//         textStyle: TextStyle(
//           fontFamily: 'Clash Display',
//           fontWeight: FontWeight.w400,
//           fontSize: 15,
//           color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//         ),
//       ),
//     );
//   }

//   List<PieSeries<ChartSampleData, String>> _getRadiusPieSeries() {
//     return <PieSeries<ChartSampleData, String>>[
//       PieSeries<ChartSampleData, String>(
//         dataSource: <ChartSampleData>[
//           ChartSampleData(x: 'Healthy', y: 551500, text: '53.7%'),
//           ChartSampleData(x: 'Septoria', y: 312685, text: '59.6%'),
//           ChartSampleData(x: 'Brown Rust', y: 350000, text: '72.5%'),
//           ChartSampleData(x: 'Yellow Rust', y: 301000, text: '85.8%'),
//           ChartSampleData(x: 'Mildew', y: 300000, text: '90.5%'),
//         ],
//         xValueMapper: (ChartSampleData data, _) => data.x,
//         yValueMapper: (ChartSampleData data, _) => data.y,
//         pointRadiusMapper: (ChartSampleData data, _) => data.text,
//         dataLabelSettings: const DataLabelSettings(
//           isVisible: false,
//           labelPosition: ChartDataLabelPosition.outside,
//         ),
//       ),
//     ];
//   }
// }
