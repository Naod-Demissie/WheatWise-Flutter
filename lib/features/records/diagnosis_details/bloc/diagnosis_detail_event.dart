import 'package:equatable/equatable.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class DiagnosisDetailEvent extends Equatable {
  const DiagnosisDetailEvent();
}

class LoadDiagnosisDetailEvent extends DiagnosisDetailEvent {
  final Diagnosis diagnosis;

  @override
  List<Object> get props => [diagnosis];

  const LoadDiagnosisDetailEvent({required this.diagnosis});
}
