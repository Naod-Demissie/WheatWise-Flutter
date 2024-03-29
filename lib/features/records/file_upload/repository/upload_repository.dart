import 'package:wheatwise/features/records/file_upload/data_provider/upload_data_provider.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

class UploadRepository {
  final UploadDataProvider uploadDataProvider = UploadDataProvider();

  UploadRepository();

  Future<Diagnosis> uploadLeaf(
    String fileName,
    int uploadTime,
    String filePath,
    bool isServerDiagnosed,
  ) async {
    try {
      Diagnosis detectedLeaf = await uploadDataProvider.uploadLeaf(
        fileName,
        uploadTime,
        filePath,
        isServerDiagnosed,
      );
      return detectedLeaf;
    } catch (e) {
      rethrow;
    }
  }
}
