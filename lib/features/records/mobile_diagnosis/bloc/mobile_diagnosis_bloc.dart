import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
import 'package:wheatwise/features/records/file_upload/exceptions/upload_exceptions.dart';
import 'package:wheatwise/features/records/mobile_diagnosis/bloc/mobile_diagnosis_event.dart';
import 'package:wheatwise/features/records/mobile_diagnosis/bloc/mobile_diagnosis_state.dart';

class MobileDiagnosisBloc
    extends Bloc<MobileDiagnosisEvent, MobileDiagnosisState> {
  MobileDiagnosisBloc() : super(InitialMobileDiagnosisState()) {
    on<StartMobileDiagnosisEvent>((event, emit) async {
      emit(MobileDiagnosisLoadingState());
      try {
        final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>("Diagnosis");

        Diagnosis diagnosis = Diagnosis(
          mobileId: const Uuid().v4(),
          serverId: '',
          fileName: event.fileName,
          filePath: event.filePath,
          // filePath: originalLeafImage,
          uploadTime: event.uploadTime,
          modelDiagnosis: event.modelDiagnosis,
          manualDiagnosis: '',
          isBookmarked: false,
          isServerDiagnosed: false,
          confidenceScore: event.confidenceScore,
        );
        int key = await diagnosisBox.add(diagnosis);
        diagnosisBox.put(key, diagnosis);

        List<Diagnosis> diagnoses = diagnosisBox.values.toList();
        emit(MobileDiagnosisSuccessState(diagnoses));
      } on ImageNotLeaf {
        emit(ImageNotLeafState());
      } catch (error) {
        print(error.toString());
        emit(MobileDiagnosisFailureState());
      }
    });
  }
}
