import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_event.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_state.dart';

class DiagnosisDetailBloc
    extends Bloc<DiagnosisDetailEvent, DiagnosisDetailState> {
  DiagnosisDetailBloc() : super(InitialDiagnosisDetailState()) {
    on<LoadDiagnosisDetailEvent>((event, emit) async {
      emit(DiagnosisDetailLoadingState());
      try {
        emit(DiagnosisDetailSuccessState(event.diagnosis));
    } catch (error) {
      print(error.toString());
        emit(DiagnosisDetailFailureState(error: error.toString()));
      }
    });
  }
}
