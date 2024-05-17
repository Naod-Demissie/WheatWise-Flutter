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