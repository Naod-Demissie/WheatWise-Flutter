import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
import 'package:wheatwise/features/records/manual_diagnosis/bloc/manual_diagnosis_event.dart';
import 'package:wheatwise/features/records/manual_diagnosis/bloc/manual_diagnosis_state.dart';
import 'package:wheatwise/features/records/manual_diagnosis/repository/manual_diagnosis_repository.dart';

class ManualDiagnosisBloc
    extends Bloc<ManualDiagnosisEvent, ManualDiagnosisState> {
  final ManualDiagnosisRepo manualDiagnosisRepo = ManualDiagnosisRepo();
  ManualDiagnosisBloc() : super(ManualDiagnosisInitial()) {
    on<ManualDiagnosisEdit>((event, emit) async {
      try {
        emit(ManualDiagnosisEditing());
      } catch (error) {
        print(error.toString());
        emit(ManualDiagnosisFailed(errMsg: error.toString()));
      }
    });
    on<ManualDiagnosisCancel>((ManualDiagnosisCancel event,
        Emitter<ManualDiagnosisState> emit) async {
      try {
        emit(ManualDiagnosisInitial());
      } catch (error) {
        print(error.toString());
        emit(ManualDiagnosisFailed(errMsg: error.toString()));
      }
    });
    on<ManualDiagnosisSave>(
        (ManualDiagnosisSave event, Emitter<ManualDiagnosisState> emit) async {
      try {
        emit(ManualDiagnosisLoading());
        // await manualDiagnosisRepo.updateManualDiagnosis(
        //     event.serverId, event.manualDiagnosis);

        final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>('Diagnosis');
        int key = diagnosisBox.keys.firstWhere((key) {
          var value = diagnosisBox.get(key);
          return value != null && value.mobileId == event.mobileId;
        }, orElse: () => null);

        print('key: $key');
        // int key = diagnosisBox.keys.firstWhere((key) {
        //   var value = diagnosisBox.get(key);
        //   return value != null && value.serverId == event.serverId;
        // }, orElse: () => null);

        Diagnosis? diagnosis = diagnosisBox.get(key);

        if (diagnosis != null) {
          diagnosis.manualDiagnosis = event.manualDiagnosis;
          diagnosisBox.putAt(key, diagnosis);
          print('manual diagnosis');
          print(diagnosis);

          emit(ManualDiagnosisSaved());
        } else {
          emit(ManualDiagnosisFailed(errMsg: 'Diagnosis not found'));
        }
      } catch (error) {
        print(error.toString());
        emit(ManualDiagnosisFailed(errMsg: error.toString()));
      }
    });
  }
}
