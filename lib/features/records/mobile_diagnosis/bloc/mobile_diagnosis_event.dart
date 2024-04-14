abstract class MobileDiagnosisEvent {
  const MobileDiagnosisEvent();
}

class StartMobileDiagnosisEvent extends MobileDiagnosisEvent {
  final String fileName;
  final int uploadTime;
  final String filePath;
  final String modelDiagnosis;
  final List<double> confidenceScore;

  const StartMobileDiagnosisEvent({
    required this.fileName,
    required this.uploadTime,
    required this.filePath,
    required this.modelDiagnosis,
    required this.confidenceScore,
  });
}
