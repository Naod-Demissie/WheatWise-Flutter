abstract class EditProfileEvents {}

class EditProfileEvent extends EditProfileEvents {
  String username;
  String prefix;
  String firstName;
  String lastName;
  String region;
  String zone;
  String woreda;
  String profilePicPath;

  EditProfileEvent({
    required this.username,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    required this.region,
    required this.zone,
    required this.woreda,
    required this.profilePicPath,
  });
}

class LoadEditProfileEvent extends EditProfileEvents {
  LoadEditProfileEvent();
}
