abstract class ManualDiagnosisState {}

class ManualDiagnosisInitial extends ManualDiagnosisState {}

class ManualDiagnosisLoading extends ManualDiagnosisState {}

class ManualDiagnosisEditing extends ManualDiagnosisState {}

class ManualDiagnosisSaved extends ManualDiagnosisState {
  ManualDiagnosisSaved();
}

class ManualDiagnosisFailed extends ManualDiagnosisState {
  final String errMsg;
  ManualDiagnosisFailed({required this.errMsg});
}
