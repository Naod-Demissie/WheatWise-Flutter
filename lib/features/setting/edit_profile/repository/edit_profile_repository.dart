import 'package:wheatwise/features/setting/edit_profile/data_provider/edit_profile_data_provider.dart';

class EditProfileRepository {
  EditProfileDataProvider editProfileDataProvider = EditProfileDataProvider();

  Future<bool> editProfile({
    required String username,
    required String prefix,
    required String firstName,
    required String lastName,
    required String region,
    required String zone,
    required String woreda,
    required String profilePicPath,
  }) async {
    try {
      bool changed = await editProfileDataProvider.editProfile(
          username: username,
          prefix: prefix,
          firstName: firstName,
          lastName: lastName,
          region: region,
          zone: zone,
          woreda: woreda,
          profilePicPath: profilePicPath);

      if (!changed) {
        throw Exception();
      }
      return changed;
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}
