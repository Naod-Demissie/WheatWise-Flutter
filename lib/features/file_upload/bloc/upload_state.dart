import 'package:equatable/equatable.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class UploadState extends Equatable {
  const UploadState();
}

class InitialUploadState extends UploadState {
  @override
  List<Object?> get props => [];
}

class UploadLoadingState extends UploadState {
  @override
  List<Object?> get props => [];
}

class UploadSuccessState extends UploadState {
  final List<Diagnosis> detectedLeaf;

  const UploadSuccessState(this.detectedLeaf);

  @override
  List<Object?> get props => [detectedLeaf];
}

class UploadImageNotLeafState extends UploadState {
  @override
  List<Object?> get props => [];
}

class NoInternetUploadState extends UploadState {
  @override
  List<Object?> get props => [];
}

class UploadFailureState extends UploadState {
  @override
  List<Object?> get props => [];
}
