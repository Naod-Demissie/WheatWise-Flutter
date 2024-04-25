// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';

// import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
// import 'package:wheatwise/features/records/file_upload/exceptions/upload_exceptions.dart';
// import 'package:wheatwise/features/records/sync_data/bloc/sync_diagnosis_event.dart';
// import 'package:wheatwise/features/records/sync_data/bloc/sync_diagnosis_state.dart';
// import 'package:wheatwise/features/records/sync_data/repository/sync_diagnosis_repository.dart';

// class SyncDiagnosisBloc extends Bloc<SyncDiagnosisEvent, SyncDiagnosisState> {
//   SyncDiagnosisRepository syncDiagnosisRepo = SyncDiagnosisRepository();

//   SyncDiagnosisBloc() : super(InitialSyncDiagnosisState()) {
//     on<StartSyncDiagnosisEvent>((event, emit) async {
//       emit(SyncDiagnosisLoadingState());
//       try {
//         final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>("Diagnosis");
//         final diagnosis =
//             await syncDiagnosisRepo.syncDiagnosis(event.diagnosis);
//         int key = await diagnosisBox.add(diagnosis);
//         diagnosisBox.put(key, diagnosis);
//         List<Diagnosis> diagnoses = diagnosisBox.values.toList();
//         emit(SyncDiagnosisSuccessState(diagnoses));
//       } on ImageNotLeaf {
//         emit(SyncDiagnosisImageNotLeafState());
//       } on NoInternet {
//         emit(NoInternetSyncDiagnosisState());
//       } catch (error) {
//         print(error.toString());
//         emit(SyncDiagnosisFailureState());
//       }
//     });
//   }
// }
