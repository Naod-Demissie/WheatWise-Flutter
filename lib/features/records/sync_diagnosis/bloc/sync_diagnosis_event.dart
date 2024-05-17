import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class SyncDiagnosisEvent {
  const SyncDiagnosisEvent();
}

class StartSyncDiagnosisEvent extends SyncDiagnosisEvent {
  final Diagnosis diagnosis;

  const StartSyncDiagnosisEvent({
    required this.diagnosis,
  });
}

class StartSyncAllDiagnosisEvent extends SyncDiagnosisEvent {
  const StartSyncAllDiagnosisEvent();
}
