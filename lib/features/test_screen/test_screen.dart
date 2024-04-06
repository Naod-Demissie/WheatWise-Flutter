// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// final ImagePicker imagePicker = ImagePicker();
// final ImageCropper imageCropper = ImageCropper();

// File? _image;

// class _TestScreenState extends State<TestScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             final file =
//                 await imagePicker.pickImage(source: ImageSource.gallery);
//             if (file != null) {
//               final croppedFile = await cropImage(file.path);
//               if (croppedFile != null) {
//                 setState(() {
//                   _image = File(croppedFile.path);
//                 });
//               }
//             }
//           },
//           child: const Text("Choose from Gallery"),
//         ),
//       ),
//     );
//   }

//   Future<CroppedFile?> cropImage(String filePath) async {
//     return await imageCropper.cropImage(
//       sourcePath: filePath,
//       aspectRatioPresets: [
//         CropAspectRatioPreset.square,
//         CropAspectRatioPreset.ratio3x2,
//         CropAspectRatioPreset.original,
//         CropAspectRatioPreset.ratio4x3,
//         CropAspectRatioPreset.ratio16x9
//       ],
//       uiSettings: [
//         AndroidUiSettings(
//             toolbarTitle: 'Edit Photo',
//             toolbarColor: Colors.deepOrange,
//             toolbarWidgetColor: Colors.white,
//             initAspectRatio: CropAspectRatioPreset.original,
//             lockAspectRatio: false),
//         IOSUiSettings(
//           title: 'Edit Photo',
//         ),
//       ],
//     );
//   }
// }

// class TestScreen extends StatefulWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// final ImagePicker imagePicker = ImagePicker();
// final ImageCropper imageCropper = ImageCropper();

// File? _image;

// class _TestScreenState extends State<TestScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _image == null
//                 ? const Text('No image selected.')
//                 : Image.file(_image!),
//             ElevatedButton(
//               onPressed: () async {
//                 final file =
//                     await imagePicker.pickImage(source: ImageSource.gallery);
//                 if (file != null) {
//                   final croppedFile = await cropImage(file.path);
//                   if (croppedFile != null) {
//                     setState(() {
//                       _image = File(croppedFile.path);
//                     });
//                   }
//                 }
//               },
//               child: const Text("Choose from Gallery"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<CroppedFile?> cropImage(String filePath) async {
//     return await imageCropper.cropImage(
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
// }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// final imagePicker = ImagePicker();
// final imageCropper = ImageCropper();

// File? _image;

// Future<List<XFile>> pickImage({
//   ImageSource source = ImageSource.gallery,
//   bool multiple = false,
// }) async {
//   if (multiple) {
//     return await imagePicker.pickMultiImage();
//   }

//   final file = await imagePicker.pickImage(source: source);
//   if (file != null) return [file];
//   return [];
// }

// Future<CroppedFile?> cropImage({
//   required XFile file,
//   CropStyle cropStyle = CropStyle.rectangle,
// }) async {
//   return await imageCropper.cropImage(
//     cropStyle: cropStyle,
//     sourcePath: file.path,
//   );
// }

// class _TestScreenState extends State<TestScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             // await getImage(context, useCamera: false);

//             final files = await pickImage(source: ImageSource.gallery);

//             if (files.isNotEmpty) {
//               final croppedFile = await cropImage(
//                   file: files.first, cropStyle: CropStyle.rectangle);
//               if (croppedFile != null) {
//                 setState(() => _image = File(croppedFile.path));
//               }
//             }

//             // Navigator.of(context).pop();
//           },
//           child: const Text("Choose from Gallery"),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_event.dart';
import 'package:wheatwise/features/records/file_upload/bloc/upload_bloc.dart';
import 'package:wheatwise/features/records/file_upload/bloc/upload_event.dart';
import 'package:wheatwise/features/records/diagnosis_details/screens/diagnosis_detail_screen.dart';
import 'package:wheatwise/features/records/file_upload/bloc/upload_state.dart';
import 'package:wheatwise/features/records/recent_records/bloc/bloc.dart';
import 'package:wheatwise/features/records/recent_records/bloc/recent_records_event.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  // int _currentPage = 0;

  List<String> assetPaths = [
    'assets/images/wheat-banner.jpg',
    'assets/images/wheat-banner2.jpg',
    'assets/images/wheat-banner3.jpg',
    'assets/images/wheat-banner4.jpg',
  ];
  final imagePicker = ImagePicker();
  final imageCropper = ImageCropper();

  // File? _image;

  // Future<void> getImage(BuildContext context, {required bool useCamera}) async {
  //   final source = useCamera ? ImageSource.camera : ImageSource.gallery;
  //   final pickedFile = await imagePicker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     BlocProvider.of<UploadBloc>(context).add(
  //       StartUploadEvent(
  //         fileName: pickedFile.name,
  //         uploadTime: DateTime.now().microsecondsSinceEpoch,
  //         filePath: pickedFile.path,
  //         isServerDiagnosed: true,
  //       ),
  //     );
  //   }
  // }

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadBloc, UploadState>(
      listener: (context, uploadState) async {
        if (uploadState is UploadSuccessState) {
          BlocProvider.of<DiagnosisDetailBloc>(context).add(
              LoadDiagnosisDetailEvent(diagnosis: uploadState.diagnosis.last));
          BlocProvider.of<RecentRecordsBloc>(context)
              .add(LoadRecentRecordsEvent());
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const DiagnosisDetailScreen()));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Pic and Avatar
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello Naod',
                      style: TextStyle(
                        fontFamily: 'Clash Display',
                        fontWeight: FontWeight.w600,
                        fontSize: 26,
                        color: Colors.black,
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      radius: 30,
                    ),
                  ],
                ),

                // PageView.builder(
                //   itemCount: assetPaths.length,
                //   onPageChanged: (int page) {
                //     setState(() {
                //       _currentPage = page;
                //     });
                //   },
                //   itemBuilder: (context, index) {
                //     return wheatwiseCard(assetPaths[index]);
                //   },
                // ),
                const SizedBox(height: 20),

                // Wheatwise card
                wheatwiseCard(assetPaths[2]),

                const SizedBox(height: 20),
                // Detect Now Button

                customElevatedButton(
                  onPressed: () => showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12))),
                      context: context,
                      builder: (context) => detectNowPopup()),
                  text: "Detect Now",
                  iconPath: 'assets/icons/scan-icon.svg',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detectNowPopup() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Detect disease using',
            style: TextStyle(
              fontFamily: 'Clash Display',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),

          //Choose from Gallery Button
          customElevatedButton(
            onPressed: () async {
              // await getImage(context, useCamera: false);

              final files =
                  await pickImage(source: ImageSource.gallery, multiple: false);

              if (files.isNotEmpty) {
                final croppedFile = await cropImage(files.first.path);
                if (croppedFile != null) {
                  BlocProvider.of<UploadBloc>(context).add(
                    StartUploadEvent(
                      fileName: files.first.name,
                      uploadTime: DateTime.now().microsecondsSinceEpoch,
                      filePath: croppedFile.path,
                      isServerDiagnosed: true,
                    ),
                  );
                }
              }

              Navigator.of(context).pop();
            },
            text: "Choose from Gallery",
            iconPath: 'assets/icons/scan-icon.svg',
          ),
          // customElevatedButton(
          //   onPressed: () async {
          //     await getImage(context, useCamera: false);
          //     Navigator.of(context).pop();
          //   },
          //   text: "Choose from Gallery",
          //   iconPath: 'assets/icons/scan-icon.svg',
          // ),

          const SizedBox(height: 15),
          const Text(
            'or',
            style: TextStyle(
              fontFamily: 'Clash Display',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),

          //Capture from Camera Button
          customElevatedButton(
            onPressed: () async {
              // await getImage(context, useCamera: true);
              Navigator.of(context).pop();
            },
            text: "Capture from Camera",
            iconPath: 'assets/icons/scan-icon.svg',
          ),
        ],
      ),
    );
  }

  Widget customElevatedButton({
    onPressed,
    text,
    iconPath,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromRGBO(248, 147, 29, 1),
        ),
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 52),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            color: Colors.white,
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            // style: GoogleFonts.montserrat(
            //   fontSize: 18.0,
            //   color: Colors.white,
            //   fontWeight: FontWeight.w800,
            // ),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'SF-Pro-Text',
              fontSize: 17.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget wheatwiseCard(String assetPaths) {
    return Card(
      elevation: 5,
      child: Stack(
        children: [
          // Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),

          // Card Image
          Positioned(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                assetPaths,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // wheatwise logo
          Positioned(
            bottom: 10,
            right: 10,
            child: Image.asset(
              'assets/logo/wheatwise-logo-white.png',
              fit: BoxFit.cover,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
