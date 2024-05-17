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
          mobileDiagnosis: event.mobileDiagnosis,
          manualDiagnosis: '',
          isBookmarked: false,
          isUploaded: false,
          isServerDiagnosed: false,
          confidenceScore: event.confidenceScore,
        );

        print('mobile_diagnosis');
        print(diagnosis);

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
    on<StartMultipleMobileDiagnosisEvent>((event, emit) async {
      emit(MobileDiagnosisLoadingState());
      try {
        final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>("Diagnosis");

        for (var i = 0; i < event.filePaths.length; i++) {
          Diagnosis diagnosis = Diagnosis(
            mobileId: const Uuid().v4(),
            serverId: '',
            fileName: event.fileNames[i],
            filePath: event.filePaths[i],
            uploadTime: DateTime.now().microsecondsSinceEpoch,
            mobileDiagnosis: event.mobileDiagnoses[i],
            manualDiagnosis: '',
            isBookmarked: false,
            isUploaded: false,
            isServerDiagnosed: false,
            confidenceScore: event.confidenceScores[i],
          );

          int key = await diagnosisBox.add(diagnosis);
          diagnosisBox.put(key, diagnosis);
        }

        List<Diagnosis> diagnoses = diagnosisBox.values.toList();
        emit(MultipleMobileDiagnosisSuccessState(diagnoses));
      } on ImageNotLeaf {
        emit(ImageNotLeafState());
      } catch (error) {
        print(error.toString());
        emit(MobileDiagnosisFailureState());
      }
    });
  }
}