import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class UploadState {}

class InitialUploadState extends UploadState {}

class UploadLoadingState extends UploadState {}

class UploadSuccessState extends UploadState {
  final List<Diagnosis> diagnosis;

  UploadSuccessState(this.diagnosis);
}

class UploadImageNotLeafState extends UploadState {}

class NoInternetUploadState extends UploadState {}

class UploadFailureState extends UploadState {}
