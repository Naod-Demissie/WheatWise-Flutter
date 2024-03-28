import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:wheatwise/features/file_upload/bloc/upload_event.dart';
import 'package:wheatwise/features/file_upload/bloc/upload_state.dart';
import 'package:wheatwise/features/file_upload/exceptions/upload_exceptions.dart';
import 'package:wheatwise/features/file_upload/repository/upload_reposiitory.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadRepository uploadRepo = UploadRepository();

  UploadBloc() : super(InitialUploadState()) {
    on<StartUploadEvent>((event, emit) async {
      emit(UploadLoadingState());
      try {
        final Box<Diagnosis> detectedLeafBox = Hive.box<Diagnosis>("Diagnosis");
        final detectedLeaf = await uploadRepo.uploadLeaf(
          event.fileName,
          event.uploadTime,
          event.filePath,
          event.isServerDiagnosed,
        );
        int key = await detectedLeafBox.add(detectedLeaf);
        detectedLeaf.serverId = key.toString();
        detectedLeafBox.put(key, detectedLeaf);
        List<Diagnosis> detectedLeafs = detectedLeafBox.values.toList();
        emit(UploadSuccessState(detectedLeafs));
      } on ImageNotLeaf {
        emit(UploadImageNotLeafState());
      } on NoInternet {
        emit(NoInternetUploadState());
      } catch (error) {
        emit(UploadFailureState());
      }
    });
  }
}
