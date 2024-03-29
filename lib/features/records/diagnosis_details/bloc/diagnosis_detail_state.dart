import 'package:wheatwise/features/records/diagnosis_details/model/leaf_detail.dart';

abstract class DiagnosisDetailState {}

class InitialDiagnosisDetailState extends DiagnosisDetailState {}

class DiagnosisDetailLoadingState extends DiagnosisDetailState {}

class DiagnosisDetailSuccessState extends DiagnosisDetailState {
  final LeafDetail leafDetail;

  DiagnosisDetailSuccessState(this.leafDetail);
}

class DiagnosisDetailFailureState extends DiagnosisDetailState {
  final String error;

  DiagnosisDetailFailureState({required this.error});
}
