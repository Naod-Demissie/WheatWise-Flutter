import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
import 'package:wheatwise/features/records/recent_records/bloc/recent_records_event.dart';
import 'package:wheatwise/features/records/recent_records/bloc/recent_records_state.dart';

class RecentRecordsBloc extends Bloc<RecentRecordsEvent, RecentRecordsState> {
  RecentRecordsBloc() : super(InitialRecentRecordsState()) {
    on<LoadRecentRecordsEvent>((event, emit) async {
      emit(RecentRecordsLoadingState());
      try {
        final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>("Diagnosis");
        List<Diagnosis> diagnoses =
            diagnosisBox.values.toList().reversed.toList();
        emit(RecentRecordsSuccessState(diagnoses));
      } catch (error) {
        print(error.toString());
        emit(RecentRecordsFailureState(error: error.toString()));
      }
    });
  }
}