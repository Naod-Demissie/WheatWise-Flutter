// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ManualDiagnosisEvent {}

class ManualDiagnosisEdit extends ManualDiagnosisEvent {}


class ManualDiagnosisCancel extends ManualDiagnosisEvent {}

class ManualDiagnosisSave extends ManualDiagnosisEvent {
  final String serverId;
  final String manualDiagnosis;

  ManualDiagnosisSave({
    required this.serverId,
    required this.manualDiagnosis,
  });
  
}
