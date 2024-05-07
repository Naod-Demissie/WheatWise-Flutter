import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
import 'package:wheatwise/features/records/sync_diagnosis/data_provider/sync_diagnosis_data_provider.dart';

class SyncDiagnosisRepository {
  final SyncDiagnosisDataProvider syncDiagnosisDataProvider =
      SyncDiagnosisDataProvider();

  SyncDiagnosisRepository();

  Future<Diagnosis> syncDiagnosis(
    Diagnosis diagnosis,
  ) async {
    try {
      Diagnosis detectedLeaf =
          await syncDiagnosisDataProvider.syncDiagnosis(diagnosis);
      return detectedLeaf;
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}
