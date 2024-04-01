import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class DiagnosisDetailState {}

class InitialDiagnosisDetailState extends DiagnosisDetailState {}

class DiagnosisDetailLoadingState extends DiagnosisDetailState {}

class DiagnosisDetailSuccessState extends DiagnosisDetailState {
  final Diagnosis diagnosis;

  DiagnosisDetailSuccessState(this.diagnosis);
}

class DiagnosisDetailFailureState extends DiagnosisDetailState {
  final String error;

  DiagnosisDetailFailureState({required this.error});
}
