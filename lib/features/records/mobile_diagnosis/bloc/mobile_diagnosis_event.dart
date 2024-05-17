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
class StartMultipleMobileDiagnosisEvent extends MobileDiagnosisEvent {
  final List<String> fileNames;
  final List<String> filePaths;
  final List<String> mobileDiagnoses;
  final List<List<double>> confidenceScores;

  const StartMultipleMobileDiagnosisEvent({
    required this.fileNames,
    required this.filePaths,
    required this.mobileDiagnoses,
    required this.confidenceScores,
  });
}



// abstract class MobileDiagnosisEvent {
//   const MobileDiagnosisEvent();
// }

// class StartMobileDiagnosisEvent extends MobileDiagnosisEvent {
//   final String fileName;
//   final int uploadTime;
//   final String filePath;
//   final String mobileDiagnosis;
//   final List<double> confidenceScore;

//   const StartMobileDiagnosisEvent({
//     required this.fileName,
//     required this.uploadTime,
//     required this.filePath,
//     required this.mobileDiagnosis,
//     required this.confidenceScore,
//   });
// }
