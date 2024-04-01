import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/records/manual_diagnosis/bloc/manual_diagnosis_event.dart';
import 'package:wheatwise/features/records/manual_diagnosis/bloc/manual_diagnosis_state.dart';
import 'package:wheatwise/features/records/manual_diagnosis/repository/manual_diagnosis_repository.dart';

class ManualDiagnosisBloc
    extends Bloc<ManualDiagnosisEvent, ManualDiagnosisState> {
  final ManualDiagnosisRepo manualDiagnosisRepo = ManualDiagnosisRepo();
  ManualDiagnosisBloc() : super(ManualDiagnosisInitial()) {
    on<ManualDiagnosisEdit>(onManualDiagnosisEdit);
    on<ManualDiagnosisCancel>(onManualDiagnosisCancel);
    on<ManualDiagnosisSave>(onManualDiagnosisSave);
  }

  Future<void> onManualDiagnosisEdit(
      ManualDiagnosisEdit event, Emitter<ManualDiagnosisState> emit) async {
    try {
      emit(ManualDiagnosisEditing());
    } catch (e) {
      emit(ManualDiagnosisFailed(errMsg: e.toString()));
    }
  }

  Future<void> onManualDiagnosisCancel(
      ManualDiagnosisCancel event, Emitter<ManualDiagnosisState> emit) async {
    try {
      emit(ManualDiagnosisInitial());
    } catch (e) {
      emit(ManualDiagnosisFailed(errMsg: e.toString()));
    }
  }

  Future<void> onManualDiagnosisSave(
      ManualDiagnosisSave event, Emitter<ManualDiagnosisState> emit) async {
    try {
      emit(ManualDiagnosisLoading());
      await manualDiagnosisRepo.updateManualDiagnosis(
          event.serverId, event.manualDiagnosis);
      emit(ManualDiagnosisSaved());
    } catch (e) {
      emit(ManualDiagnosisFailed(errMsg: e.toString()));
    }
  }
}
