import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class SyncDiagnosisState {}

class InitialSyncDiagnosisState extends SyncDiagnosisState {}

class SyncDiagnosisLoadingState extends SyncDiagnosisState {}

class SyncDiagnosisSuccessState extends SyncDiagnosisState {
  final Diagnosis diagnosis;

  SyncDiagnosisSuccessState(this.diagnosis);
}

class SyncDiagnosisImageNotLeafState extends SyncDiagnosisState {}

class NoInternetSyncDiagnosisState extends SyncDiagnosisState {}

class SyncDiagnosisFailureState extends SyncDiagnosisState {}
