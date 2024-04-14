abstract class UploadEvent {
  const UploadEvent();
}

class StartUploadEvent extends UploadEvent {
  final String fileName;
  final int uploadTime;
  final String filePath;
  final bool isServerDiagnosed;

  const StartUploadEvent({
    required this.fileName,
    required this.uploadTime,
    required this.filePath,
    required this.isServerDiagnosed,
  });
}
