import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:wheatwise/features/records/file_upload/bloc/upload_event.dart';
import 'package:wheatwise/features/records/file_upload/bloc/upload_state.dart';
import 'package:wheatwise/features/records/file_upload/exceptions/upload_exceptions.dart';
import 'package:wheatwise/features/records/file_upload/repository/upload_repository.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadRepository uploadRepo = UploadRepository();

  UploadBloc() : super(InitialUploadState()) {
    on<StartUploadEvent>((event, emit) async {
      emit(UploadLoadingState());
      try {
        final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>("Diagnosis");
        final diagnosis = await uploadRepo.uploadLeaf(
          event.fileName,
          event.uploadTime,
          event.filePath,
          event.isServerDiagnosed,
        );
        int key = await diagnosisBox.add(diagnosis);
        diagnosisBox.put(key, diagnosis);
        List<Diagnosis> diagnoses = diagnosisBox.values.toList();
        emit(UploadSuccessState(diagnoses));
      } on ImageNotLeaf {
        emit(UploadImageNotLeafState());
      } on NoInternet {
        emit(NoInternetUploadState());
      } catch (error) {
        print(error.toString());
        emit(UploadFailureState());
      }
    });
  }
}
