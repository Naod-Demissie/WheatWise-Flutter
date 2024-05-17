import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class MobileDiagnosisState {}

class InitialMobileDiagnosisState extends MobileDiagnosisState {}

class MobileDiagnosisLoadingState extends MobileDiagnosisState {}

class MobileDiagnosisSuccessState extends MobileDiagnosisState {
  final List<Diagnosis> diagnosis;

  MobileDiagnosisSuccessState(this.diagnosis);
}

class MultipleMobileDiagnosisSuccessState extends MobileDiagnosisState {
  final List<Diagnosis> diagnosis;

  MultipleMobileDiagnosisSuccessState(this.diagnosis);
}

class ImageNotLeafState extends MobileDiagnosisState {}

class MobileDiagnosisFailureState extends MobileDiagnosisState {}
