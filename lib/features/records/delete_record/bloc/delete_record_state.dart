import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class DeleteRecordState {}

class InitialDeleteRecordState extends DeleteRecordState {}

class DeleteRecordLoadingState extends DeleteRecordState {}

class DeleteRecordSuccessState extends DeleteRecordState {
  final List<Diagnosis> diagnoses;

  DeleteRecordSuccessState(this.diagnoses);
}

class DeleteRecordFailureState extends DeleteRecordState {
  final String error;

  DeleteRecordFailureState({required this.error});
}
