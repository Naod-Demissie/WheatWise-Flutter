import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wheatwise/features/records/delete_record/bloc/delete_record_event.dart';
import 'package:wheatwise/features/records/delete_record/bloc/delete_record_state.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

class DeleteRecordBloc extends Bloc<DeleteRecordEvent, DeleteRecordState> {
  DeleteRecordBloc() : super(InitialDeleteRecordState()) {
    on<StartDeleteRecordEvent>((event, emit) async {
      emit(DeleteRecordLoadingState());
      try {
        final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>('Diagnosis');
        List<Diagnosis> diagnoses = diagnosisBox.values.toList();
        await diagnosisBox
            .delete(event.diagnosis.mobileId); //! this might cause error
        diagnoses = diagnosisBox.values.toList().reversed.toList();
        // await diagnosisBox.close();

        emit(DeleteRecordSuccessState(diagnoses));
      } catch (error) {
        print(error.toString());
        emit(DeleteRecordFailureState(error: error.toString()));
      }
    });
  }
}

