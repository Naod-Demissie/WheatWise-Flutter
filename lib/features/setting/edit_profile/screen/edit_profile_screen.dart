import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/setting/edit_profile/components/edit_profile_form.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_state.dart';

class EditProfileScreen extends StatefulWidget {
  final VoidCallback? onProfilePictureChanged;

  const EditProfileScreen({super.key, this.onProfilePictureChanged});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late SharedPreferences _prefs;
  final ImagePicker imagePicker = ImagePicker();
  final ImageCropper imageCropper = ImageCropper();
  String? _profilePicPath;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  void _loadSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    String? profilePicPath = _prefs.getString('profilePicPath');
    setState(() {
      _profilePicPath = profilePicPath;
    });
  }

  Future<List<XFile>> pickImage({
    ImageSource source = ImageSource.gallery,
    bool multiple = false,
  }) async {
    if (multiple) {
      return await imagePicker.pickMultiImage();
    }

    final file = await imagePicker.pickImage(source: source);
    if (file != null) return [file];
    return [];
  }

  Future<CroppedFile?> cropImage(String filePath) async {
    return await imageCropper.cropImage(
      maxHeight: 200,
      maxWidth: 200,
      sourcePath: filePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Edit Photo',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            statusBarColor: Colors.black,
            backgroundColor: Colors.black,
            activeControlsWidgetColor: const Color.fromRGBO(248, 147, 29, 1),
            cropFrameColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Edit Photo',
        ),
      ],
    );
  }

  Future<void> updateProfilePicture(String? profilePicPath) async {
    final files = await pickImage(source: ImageSource.gallery, multiple: false);

    if (files.isNotEmpty) {
      final croppedFile = await cropImage(files.first.path);
      if (croppedFile != null) {
        await _prefs.setString('profilePicPath', croppedFile.path);
        setState(() {
          _profilePicPath = croppedFile.path;
        });
        if (widget.onProfilePictureChanged != null) {
          widget.onProfilePictureChanged!();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Card(
                  elevation: 0,
                  shape: const CircleBorder(),
                  color: Colors.black.withOpacity(0.6),
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
              ),
              centerTitle: true,
              title: Text(
                'Edit Profile',
                style: TextStyle(
                  fontFamily: 'Clash Display',
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                  color: BlocProvider.of<ThemeBloc>(context).state.textColor,
                ),
              ),
            ),
            body: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/wheat-field-bg2.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Container(
                  color: BlocProvider.of<ThemeBloc>(context)
                      .state
                      .backgroundColor
                      .withOpacity(0.65),
                  width: double.infinity,
                  height: double.infinity,
                ),
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  _profilePicPath != null ? null : Colors.grey,
                              backgroundImage: _profilePicPath != null
                                  ? FileImage(File(_profilePicPath!))
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.grey.shade300,
                                ),
                                onPressed: () async {
                                  await updateProfilePicture(_profilePicPath);
                                },
                              ),
                            ),
                          ],
                        ),
                        EditProfileForm(_prefs),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wheatwise/features/setting/edit_profile/components/edit_profile_form.dart';
// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
// import 'package:wheatwise/features/theme/bloc/theme_state.dart';

// class EditProfileScreen extends StatefulWidget {
//   final VoidCallback? onProfilePictureChanged;

//   const EditProfileScreen({super.key, this.onProfilePictureChanged});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   late SharedPreferences _prefs;
//   final ImagePicker imagePicker = ImagePicker();
//   final ImageCropper imageCropper = ImageCropper();
//   String? _profilePicPath;

//   @override
//   void initState() {
//     super.initState();
//     _loadSharedPreferences();
//   }

//   void _loadSharedPreferences() async {
//     _prefs = await SharedPreferences.getInstance();
//     String? profilePicPath = _prefs.getString('profilePicPath');
//     setState(() {
//       _profilePicPath = profilePicPath;
//     });
//   }

//   Future<List<XFile>> pickImage({
//     ImageSource source = ImageSource.gallery,
//     bool multiple = false,
//   }) async {
//     if (multiple) {
//       return await imagePicker.pickMultiImage();
//     }

//     final file = await imagePicker.pickImage(source: source);
//     if (file != null) return [file];
//     return [];
//   }

//   Future<CroppedFile?> cropImage(String filePath) async {
//     return await imageCropper.cropImage(
//       maxHeight: 200,
//       maxWidth: 200,
//       sourcePath: filePath,
//       aspectRatioPresets: [
//         CropAspectRatioPreset.ratio3x2,
//         CropAspectRatioPreset.square,
//         CropAspectRatioPreset.original,
//         CropAspectRatioPreset.ratio4x3,
//         CropAspectRatioPreset.ratio16x9
//       ],
//       uiSettings: [
//         AndroidUiSettings(
//             toolbarTitle: 'Edit Photo',
//             toolbarColor: Colors.black,
//             toolbarWidgetColor: Colors.white,
//             statusBarColor: Colors.black,
//             backgroundColor: Colors.black,
//             activeControlsWidgetColor: const Color.fromRGBO(248, 147, 29, 1),
//             cropFrameColor: Colors.black,
//             initAspectRatio: CropAspectRatioPreset.original,
//             lockAspectRatio: false),
//         IOSUiSettings(
//           title: 'Edit Photo',
//         ),
//       ],
//     );
//   }

//   Future<void> updateProfilePicture(String? profilePicPath) async {
//     final files = await pickImage(source: ImageSource.gallery, multiple: false);

//     if (files.isNotEmpty) {
//       final croppedFile = await cropImage(files.first.path);
//       if (croppedFile != null) {
//         await _prefs.setString('profilePicPath', croppedFile.path);
//         setState(() {
//           _profilePicPath = croppedFile.path;
//         });
//         if (widget.onProfilePictureChanged != null) {
//           widget.onProfilePictureChanged!();
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, themeState) {
//         return SafeArea(
//           child: Scaffold(
//             extendBodyBehindAppBar: true,
//             appBar: AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               leading: Padding(
//                 padding: const EdgeInsets.only(left: 2.0),
//                 child: Card(
//                   elevation: 0,
//                   shape: const CircleBorder(),
//                   color: Colors.black.withOpacity(0.6),
//                   margin: const EdgeInsets.all(10),
//                   child: InkWell(
//                     onTap: () => Navigator.of(context).pop(),
//                     child: Icon(
//                       Icons.close,
//                       size: 20,
//                       color: Colors.grey.shade200,
//                     ),
//                   ),
//                 ),
//               ),
//               centerTitle: true,
//               title: Text(
//                 'Edit Profile',
//                 style: TextStyle(
//                   fontFamily: 'Clash Display',
//                   fontWeight: FontWeight.w600,
//                   fontSize: 26,
//                   color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//                 ),
//               ),
//             ),
//             body: Stack(
//               children: [
//                 Image.asset(
//                   'assets/images/wheat-field-bg2.png',
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: double.infinity,
//                 ),
//                 Container(
//                   color: BlocProvider.of<ThemeBloc>(context)
//                       .state
//                       .backgroundColor
//                       .withOpacity(0.65),
//                   width: double.infinity,
//                   height: double.infinity,
//                 ),
//                 SingleChildScrollView(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   child: Center(
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 100),
//                         Stack(
//                           children: [
//                             CircleAvatar(
//                               radius: 65,
//                               backgroundColor:
//                                   _profilePicPath != null ? null : Colors.grey,
//                               backgroundImage: _profilePicPath != null
//                                   ? FileImage(File(_profilePicPath!))
//                                   : null,
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: IconButton(
//                                 icon: Icon(
//                                   Icons.add_a_photo,
//                                   color: Colors.grey.shade300,
//                                 ),
//                                 onPressed: () async {
//                                   await updateProfilePicture(_profilePicPath);
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         EditProfileForm(_prefs)
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
