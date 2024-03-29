import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_event.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_state.dart';
import 'package:wheatwise/features/records/diagnosis_details/model/leaf_detail.dart';

class DiagnosisDetailBloc
    extends Bloc<DiagnosisDetailEvent, DiagnosisDetailState> {
  DiagnosisDetailBloc() : super(InitialDiagnosisDetailState()) {
    on<LoadDiagnosisDetailEvent>((event, emit) async {
      emit(DiagnosisDetailLoadingState());
      try {
        LeafDetail leafDetail = LeafDetail(
          diagnosis: event.diagnosis,
          originalImage: File(event.diagnosis.filePath),
        );
        emit(DiagnosisDetailSuccessState(leafDetail));
      } catch (e) {
        print(e.toString());
        emit(DiagnosisDetailFailureState(error: e.toString()));
      }
    });
  }
}
