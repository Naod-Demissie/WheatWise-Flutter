abstract class MobileDiagnosisEvent {
  const MobileDiagnosisEvent();
}

class StartMobileDiagnosisEvent extends MobileDiagnosisEvent {
  final String fileName;
  final int uploadTime;
  final String filePath;
  final String mobileDiagnosis;
  final List<double> confidenceScore;

  const StartMobileDiagnosisEvent({
    required this.fileName,
    required this.uploadTime,
    required this.filePath,
    required this.mobileDiagnosis,
    required this.confidenceScore,
  });
}
