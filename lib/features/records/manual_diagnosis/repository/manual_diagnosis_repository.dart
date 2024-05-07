import 'package:wheatwise/features/records/manual_diagnosis/data_provider/manual_diagnosis_data_provider.dart';

class ManualDiagnosisRepo {
  ManualDiagnosisProvider manualDiagnosisProvider = ManualDiagnosisProvider();

  Future<String> updateManualDiagnosis(
    String serverId,
    String manualDiagnosis,
  ) async {
    try {
      final result = manualDiagnosisProvider.updateManualDiagnosis(
          serverId, manualDiagnosis);
      return result;
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}
