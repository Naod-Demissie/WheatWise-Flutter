import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class SyncDiagnosisState {}

class InitialSyncDiagnosisState extends SyncDiagnosisState {}

class SyncDiagnosisLoadingState extends SyncDiagnosisState {}

class SyncDiagnosisSuccessState extends SyncDiagnosisState {
  final Diagnosis diagnosis;

  SyncDiagnosisSuccessState(this.diagnosis);
}

class NoInternetSyncDiagnosisState extends SyncDiagnosisState {}

class SyncDiagnosisFailureState extends SyncDiagnosisState {}
