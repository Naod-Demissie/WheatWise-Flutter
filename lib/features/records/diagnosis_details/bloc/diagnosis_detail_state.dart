import 'package:equatable/equatable.dart';
import 'package:wheatwise/features/records/diagnosis_details/model/leaf_detail.dart';

abstract class DiagnosisDetailState extends Equatable {
  const DiagnosisDetailState();
}

class InitialDiagnosisDetailState extends DiagnosisDetailState {
  @override
  List<Object?> get props => [];
}

class DiagnosisDetailLoadingState extends DiagnosisDetailState {
  @override
  List<Object?> get props => [];
}

class DiagnosisDetailSuccessState extends DiagnosisDetailState {
  final LeafDetail leafDetail;

  const DiagnosisDetailSuccessState(this.leafDetail);

  @override
  List<Object?> get props => [leafDetail];
}

class DiagnosisDetailFailureState extends DiagnosisDetailState {
  @override
  List<Object?> get props => [];
}
