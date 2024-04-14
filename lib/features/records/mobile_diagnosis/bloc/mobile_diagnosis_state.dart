import 'package:equatable/equatable.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class MobileDiagnosisState extends Equatable {
  const MobileDiagnosisState();
}

class InitialMobileDiagnosisState extends MobileDiagnosisState {
  @override
  List<Object?> get props => [];
}

class MobileDiagnosisLoadingState extends MobileDiagnosisState {
  @override
  List<Object?> get props => [];
}

class MobileDiagnosisSuccessState extends MobileDiagnosisState {
  final List<Diagnosis> diagnosis;

  const MobileDiagnosisSuccessState(this.diagnosis);

  @override
  List<Object?> get props => [diagnosis];
}

class ImageNotLeafState extends MobileDiagnosisState {
  @override
  List<Object?> get props => [];
}

class MobileDiagnosisFailureState extends MobileDiagnosisState {
  @override
  List<Object?> get props => [];
}
