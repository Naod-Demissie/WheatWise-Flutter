abstract class SyncDiagnosisState {}

class InitialSyncDiagnosisState extends SyncDiagnosisState {}

class SyncDiagnosisLoadingState extends SyncDiagnosisState {}

class SyncProgressState extends SyncDiagnosisState {
  final int currentCount;
  final int totalCounts;

  SyncProgressState(this.currentCount, this.totalCounts);
}

class SyncDiagnosisSuccessState extends SyncDiagnosisState {
  SyncDiagnosisSuccessState();
}

class NoInternetSyncDiagnosisState extends SyncDiagnosisState {}

class SyncDiagnosisFailureState extends SyncDiagnosisState {}

// import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

// abstract class SyncDiagnosisState {}

// class InitialSyncDiagnosisState extends SyncDiagnosisState {}

// class SyncDiagnosisLoadingState extends SyncDiagnosisState {}

// class SyncDiagnosisSuccessState extends SyncDiagnosisState {
//   final Diagnosis diagnosis;

//   SyncDiagnosisSuccessState(this.diagnosis);
// }

// class SyncProgressSuccessState extends SyncDiagnosisState {
//   final int currentCount;
//   final int totalCounts;

//   SyncProgressSuccessState(this.currentCount, this.totalCounts);
// }

// class NoInternetSyncDiagnosisState extends SyncDiagnosisState {}

// class SyncDiagnosisFailureState extends SyncDiagnosisState {}
