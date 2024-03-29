import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class DiagnosisDetailEvent {
  const DiagnosisDetailEvent();
}

class LoadDiagnosisDetailEvent extends DiagnosisDetailEvent {
  final Diagnosis diagnosis;

  const LoadDiagnosisDetailEvent({required this.diagnosis});
}
