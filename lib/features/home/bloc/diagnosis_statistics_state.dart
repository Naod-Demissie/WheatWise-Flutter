abstract class DiagnosisStatisticsState {}

class InitialDiagnosisStatisticsState extends DiagnosisStatisticsState {}

class DiagnosisStatisticsLoadingState extends DiagnosisStatisticsState {}

class DiagnosisStatisticsSuccessState extends DiagnosisStatisticsState {
  final Map<String, Map<String, int>> diagnosisStatistics;

  DiagnosisStatisticsSuccessState(this.diagnosisStatistics);
}

class DiagnosisStatisticsFailureState extends DiagnosisStatisticsState {}
