import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class DeleteRecordEvent {}

class StartDeleteRecordEvent extends DeleteRecordEvent {
  final Diagnosis diagnosis;

  StartDeleteRecordEvent({required this.diagnosis});
}
