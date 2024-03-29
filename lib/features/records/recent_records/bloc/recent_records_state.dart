import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class RecentRecordsState {}

class InitialRecentRecordsState extends RecentRecordsState {}

class RecentRecordsLoadingState extends RecentRecordsState {}

class RecentRecordsSuccessState extends RecentRecordsState {
  final List<Diagnosis> diagnoses;

  RecentRecordsSuccessState(this.diagnoses);
}

class RecentRecordsFailureState extends RecentRecordsState {
  final String error;
  RecentRecordsFailureState({required this.error});
}
