import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_bloc.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_event.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_event.dart';
import 'package:wheatwise/features/records/diagnosis_details/screens/diagnosis_detail_screen.dart';
import 'package:wheatwise/features/records/mobile_diagnosis/bloc/mobile_diagnosis_bloc.dart';
import 'package:wheatwise/features/records/mobile_diagnosis/bloc/mobile_diagnosis_event.dart';
import 'package:wheatwise/features/records/mobile_diagnosis/bloc/mobile_diagnosis_state.dart';
import 'package:wheatwise/features/records/recent_records/bloc/bloc.dart';
import 'package:wheatwise/features/home/components/bar_chart.dart';
import 'package:wheatwise/features/home/components/pie_chart.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_state.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late SharedPreferences _prefs;
  String? _profilePicPath;
  String? _firstName;
  bool pickedMultipleImages = false;

  List<String> assetPaths = [
    'assets/images/wheat-banner1.jpg',
    'assets/images/wheat-banner2.jpg',
  ];
  final imagePicker = ImagePicker();
  final imageCropper = ImageCropper();

  final _controller = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
    _loadModel();
  }

  void _loadSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    String? profilePicPath = _prefs.getString('profilePicPath');
    String? firstName = _prefs.getString('firstName');
    setState(() {
      _profilePicPath = profilePicPath;
      _firstName = firstName;
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
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
      sourcePath: filePath,
      maxHeight: 224,
      maxWidth: 224,
      compressQuality: 100,
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

  Future<void> _loadModel() async {
    await Tflite.loadModel(
        model:
            "assets/model/MobilenetV3large__lr_0.0003__batch_32__color_zoom_augmented__minimalistic.tflite",
        labels: "assets/model/labels.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  classifyImage(String filePath) async {
    List<dynamic>? recognitions = await Tflite.runModelOnImage(
      path: filePath,
      imageMean: 0.0,
      imageStd: 1.0,
      numResults: 5,
      threshold: 0,
      asynch: true,
    );

    if (recognitions == null) return [];
    return recognitions;
  }

  String capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<MobileDiagnosisBloc, MobileDiagnosisState>(
      listener: (context, mobileDiagnosisState) async {
        if (mobileDiagnosisState is MobileDiagnosisSuccessState) {
          if (pickedMultipleImages) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Diagnosis Done!'),
              ),
            );
          } else {
            BlocProvider.of<DiagnosisDetailBloc>(context).add(
                LoadDiagnosisDetailEvent(
                    diagnosis: mobileDiagnosisState.diagnosis.last));
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const DiagnosisDetailScreen()));
          }
          BlocProvider.of<RecentRecordsBloc>(context)
              .add(LoadRecentRecordsEvent());
        }
        // if (mobileDiagnosisState is MobileDiagnosisSuccessState) {
        //   if (pickedMultipleImages) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //         content: Text('Diagnosis Done!'),
        //       ),
        //     );
        //   } else {
        //     BlocProvider.of<DiagnosisDetailBloc>(context).add(
        //         LoadDiagnosisDetailEvent(
        //             diagnosis: mobileDiagnosisState.diagnosis.last));
        //     await Navigator.of(context).push(MaterialPageRoute(
        //         builder: (context) => const DiagnosisDetailScreen()));
        //   }
        //   BlocProvider.of<RecentRecordsBloc>(context)
        //       .add(LoadRecentRecordsEvent());
        // }
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile Pic and Avatar
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _firstName != null
                                ? 'Hello ${capitalize(_firstName!)}'
                                : 'Hello ',
                            style: TextStyle(
                              fontFamily: 'Clash Display',
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
                              color: BlocProvider.of<ThemeBloc>(context)
                                  .state
                                  .textColor,
                            ),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                _profilePicPath != null ? null : Colors.grey,
                            backgroundImage: _profilePicPath != null
                                ? FileImage(File(_profilePicPath!))
                                : null,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Wheatwise card
                      wheatwiseCard(assetPaths[1], themeState),
                      const SizedBox(height: 20),

                      // Diagnosis statistics Card
                      Column(
                        children: [
                          SizedBox(
                            height: 250,
                            child: PageView.builder(
                              controller: _controller,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                // BlocProvider.of<DiagnosisStatisticsBloc>(
                                //         context)
                                //     .add(const LoadDiagnosisStatisticsEvent());
                                return Card(
                                  color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .cardColor,
                                  elevation:
                                      themeState is DarkThemeState ? 0 : 3,
                                  child: index == 0
                                      ? const PieRadius()
                                      : const BarChart(),
                                );
                              },
                              onPageChanged: (int index) {
                                _currentPageNotifier.value = index;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CirclePageIndicator(
                              size: 8.0,
                              selectedSize: 10.0,
                              itemCount: 2,
                              currentPageNotifier: _currentPageNotifier,
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 20),

                      // Detect Now Button
                      customElevatedButton(
                        onPressed: () => showModalBottomSheet(
                            backgroundColor: BlocProvider.of<ThemeBloc>(context)
                                .state
                                .backgroundColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12))),
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
        },
      ),
    );
  }

  Widget detectNowPopup() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Detect disease using',
            style: TextStyle(
              fontFamily: 'Clash Display',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: BlocProvider.of<ThemeBloc>(context).state.textColor,
            ),
          ),
          const SizedBox(height: 15),

          //Choose from Gallery Button
          // customElevatedButton(
          //   onPressed: () async {
          //     Navigator.of(context).pop();
          //     final files =
          //         await pickImage(source: ImageSource.gallery, multiple: true);

          //     if (files.isNotEmpty) {
          //       List<String> fileNames = [];
          //       List<String> filePaths = [];
          //       List<List<double>> confidenceScores = [];
          //       List<String> labels = [];

          //       for (var file in files) {
          //         final croppedFile = await cropImage(file.path);
          //         if (croppedFile != null) {
          //           filePaths.add(file.name);
          //           fileNames.add(file.path);

          //           final recognitions = await classifyImage(croppedFile.path);
          //           var sortedData = List.from(recognitions);
          //           sortedData.sort((a, b) => a["index"].compareTo(b["index"]));
          //           List<double> scores = sortedData
          //               .map<double>((item) => item["confidence"])
          //               .toList();
          //           confidenceScores.add(scores);
          //           print(recognitions);
          //           print(recognitions[0]['label']);
          //           labels.add(recognitions[0]['label']);
          //           print(5);
          //         }
          //       }
          //       for (var i = 0; i < filePaths.length; i++) {
          //         BlocProvider.of<MobileDiagnosisBloc>(context).add(
          //           StartMobileDiagnosisEvent(
          //             fileName: fileNames[i],
          //             uploadTime: DateTime.now().microsecondsSinceEpoch,
          //             filePath: filePaths[i],
          //             confidenceScore: confidenceScores[i],
          //             mobileDiagnosis: labels[i],
          //           ),
          //         );
          //       }
          //       BlocProvider.of<DiagnosisStatisticsBloc>(context)
          //           .add(const LoadDiagnosisStatisticsEvent());
          //     }
          //   },
          //   text: "Choose from Gallery",
          //   iconPath: 'assets/icons/scan-icon.svg',
          // ),
          //Choose from Gallery Button
          customElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final files =
                  await pickImage(source: ImageSource.gallery, multiple: true);

              if (files.isNotEmpty) {
                // Multiple image picked
                if (files.length > 1) {
                  print(2332323233232323);
                  pickedMultipleImages = true;

                  List<String> fileNames = [];
                  List<String> filePaths = [];
                  List<String> croppedFilePaths = [];
                  List<List<double>> confidenceScores = [];
                  List<String> labels = [];

                  for (var file in files) {
                    final croppedFile = await cropImage(file.path);
                    if (croppedFile != null) {
                      filePaths.add(file.path);
                      fileNames.add(file.name);
                      croppedFilePaths.add(croppedFile.path);
                    }
                  }
                  for (String path in croppedFilePaths) {
                    final recognitions = await classifyImage(path);
                    var sortedData = List.from(recognitions);
                    sortedData.sort((a, b) => a["index"].compareTo(b["index"]));
                    List<double> scores = sortedData
                        .map<double>((item) => item["confidence"])
                        .toList();
                    confidenceScores.add(scores);
                    labels.add(recognitions[0]['label']);
                  }
                  for (var i = 0; i < filePaths.length; i++) {
                    BlocProvider.of<MobileDiagnosisBloc>(context).add(
                      StartMobileDiagnosisEvent(
                        fileName: fileNames[i],
                        uploadTime: DateTime.now().microsecondsSinceEpoch,
                        filePath: filePaths[i],
                        confidenceScore: confidenceScores[i],
                        mobileDiagnosis: labels[i],
                      ),
                    );
                  }
                  BlocProvider.of<DiagnosisStatisticsBloc>(context)
                      .add(const LoadDiagnosisStatisticsEvent());
                } else {
                  pickedMultipleImages = false;
                  final croppedFile = await cropImage(files.first.path);
                  if (croppedFile != null) {
                    final recognitions = await classifyImage(croppedFile.path);

                    var sortedData = List.from(recognitions);
                    sortedData.sort((a, b) => a["index"].compareTo(b["index"]));

                    List<double> confidenceScore = sortedData
                        .map<double>((item) => item["confidence"])
                        .toList();
                    BlocProvider.of<MobileDiagnosisBloc>(context).add(
                      StartMobileDiagnosisEvent(
                        fileName: files.first.name,
                        uploadTime: DateTime.now().microsecondsSinceEpoch,
                        filePath: files.first.path,
                        confidenceScore: confidenceScore,
                        mobileDiagnosis: recognitions[0]['label'],
                      ),
                    );
                    BlocProvider.of<DiagnosisStatisticsBloc>(context)
                        .add(const LoadDiagnosisStatisticsEvent());
                  }
                }
              }
            },
            text: "Choose from Gallery",
            iconPath: 'assets/icons/scan-icon.svg',
          ),
          // //Choose from Gallery Button
          // customElevatedButton(
          //   onPressed: () async {
          //     Navigator.of(context).pop();
          //     final files =
          //         await pickImage(source: ImageSource.gallery, multiple: false);

          //     if (files.isNotEmpty) {
          //       final croppedFile = await cropImage(files.first.path);
          //       if (croppedFile != null) {
          //         final recognitions = await classifyImage(croppedFile.path);

          //         var sortedData = List.from(recognitions);
          //         sortedData.sort((a, b) => a["index"].compareTo(b["index"]));

          //         List<double> confidenceScore = sortedData
          //             .map<double>((item) => item["confidence"])
          //             .toList();
          //         BlocProvider.of<MobileDiagnosisBloc>(context).add(
          //           StartMobileDiagnosisEvent(
          //             fileName: files.first.name,
          //             uploadTime: DateTime.now().microsecondsSinceEpoch,
          //             filePath: files.first.path,
          //             confidenceScore: confidenceScore,
          //             mobileDiagnosis: recognitions[0]['label'],
          //           ),
          //         );
          //         BlocProvider.of<DiagnosisStatisticsBloc>(context)
          //             .add(const LoadDiagnosisStatisticsEvent());
          //         // BlocProvider.of<MobileDiagnosisBloc>(context).add(
          //         //   StartMobileDiagnosisEvent(
          //         //     fileName: files.first.name,
          //         //     uploadTime: DateTime.now().microsecondsSinceEpoch,
          //         //     filePath: croppedFile.path,
          //         //     confidenceScore: confidenceScore,
          //         //     mobileDiagnosis: recognitions[0]['label'],
          //         //   ),
          //         // );
          //       }
          //     }
          //   },
          //   text: "Choose from Gallery",
          //   iconPath: 'assets/icons/scan-icon.svg',
          // ),
          const SizedBox(height: 15),

          Text(
            'or',
            style: TextStyle(
              fontFamily: 'Clash Display',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: BlocProvider.of<ThemeBloc>(context).state.textColor,
            ),
          ),
          const SizedBox(height: 15),

          //Capture from Camera Button
          customElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final files =
                  await pickImage(source: ImageSource.camera, multiple: false);

              if (files.isNotEmpty) {
                final croppedFile = await cropImage(files.first.path);
                if (croppedFile != null) {
                  final recognitions = await classifyImage(croppedFile.path);

                  var sortedData = List.from(recognitions);
                  sortedData.sort((a, b) => a["index"].compareTo(b["index"]));

                  List<double> confidenceScore = sortedData
                      .map<double>((item) => item["confidence"])
                      .toList();
                  BlocProvider.of<MobileDiagnosisBloc>(context).add(
                    StartMobileDiagnosisEvent(
                      fileName: files.first.name,
                      uploadTime: DateTime.now().microsecondsSinceEpoch,
                      filePath: files.first.path,
                      confidenceScore: confidenceScore,
                      mobileDiagnosis: recognitions[0]['label'],
                    ),
                  );
                  BlocProvider.of<DiagnosisStatisticsBloc>(context)
                      .add(const LoadDiagnosisStatisticsEvent());
                  // BlocProvider.of<MobileDiagnosisBloc>(context).add(
                  //   StartMobileDiagnosisEvent(
                  //     fileName: files.first.name,
                  //     uploadTime: DateTime.now().microsecondsSinceEpoch,
                  //     filePath: croppedFile.path,
                  //     confidenceScore: confidenceScore,
                  //     mobileDiagnosis: recognitions[0]['label'],
                  //   ),
                  // );
                }
              }
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

  Widget wheatwiseCard(String assetPaths, ThemeState themeState) {
    return Card(
      elevation: themeState is DarkThemeState ? 0 : 3,
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

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   late bool _loading;
//   late double _progressValue;

//   @override
//   void initState() {
//     super.initState();
//     _loading = false;
//     _progressValue = 0.0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: const Text("Progress"),
//                   content: _loading
//                       ? Column(
//                           children: [
//                             LinearProgressIndicator(
//                               backgroundColor: Colors.grey,
//                               valueColor: const AlwaysStoppedAnimation<Color>(
//                                   kPrimaryColor),
//                               value: _progressValue,
//                             ),
//                             Text('${(_progressValue * 100).round()}%'),
//                             TextButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     _loading = !_loading;
//                                     _updateProgress();
//                                   });
//                                 },
//                                 child: const Text('Update'))
//                           ],
//                         )
//                       : const Text("Process Complete!"),
//                   actions: <Widget>[
//                     TextButton(
//                       child: const Text('Close'),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//             // _startProcess();
//           },
//           child: const Text('Start Process'),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _loading = !_loading;
//               _updateProgress();
//             });
//           },
//           tooltip: 'Download',
//           child: const Icon(Icons.abc)),
//     );
//   }

//   void _updateProgress() {
//     const oneSec = Duration(seconds: 1);
//     Timer.periodic(oneSec, (Timer t) {
//       setState(() {
//         _progressValue += 0.1;

//         if (_progressValue.toStringAsFixed(1) == '1.0') {
//           _loading = false;
//           t.cancel();
//           return;
//         }
//       });
//     });
//   }
// }

// class TestScreen extends StatefulWidget {
//   @override
//   _TestScreenState createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   bool _loading = false;

//   void _startProcess() {
//     setState(() {
//       _loading = true;
//     });

//     int totalSteps = 5;
//     int currentStep = 0;

//     void _nextStep() {
//       currentStep++;
//       if (currentStep <= totalSteps) {
//         Future.delayed(Duration(seconds: 2), () {
//           setState(() {});
//           _nextStep();
//         });
//       } else {
//         setState(() {
//           _loading = false;
//         });
//       }
//     }

//     _nextStep();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Linear Progress Indicator'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text("Progress"),
//                   content: _loading
//                       ? LinearProgressIndicator(
//                           backgroundColor: Colors.grey,
//                           valueColor:
//                               AlwaysStoppedAnimation<Color>(Colors.blue),
//                         )
//                       : Text("Process Complete!"),
//                   actions: <Widget>[
//                     TextButton(
//                       child: Text('Close'),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//             _startProcess();
//           },
//           child: Text('Start Process'),
//         ),
//       ),
//     );
//   }
// }

// class TestScreen extends StatefulWidget {
//   @override
//   _TestScreenState createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   bool _loading = false;

//   void _startProcess() {
//     setState(() {
//       _loading = true;
//     });

//     // Simulating process with 2-second delay for each value
//     for (int i = 0; i <= 5; i++) {
//       Future.delayed(Duration(seconds: 2), () {
//         if (i == 5) {
//           setState(() {
//             _loading = false;
//           });
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Linear Progress Indicator'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text("Progress"),
//                   content: _loading
//                       ? LinearProgressIndicator(
//                           backgroundColor: Colors.grey,
//                           valueColor:
//                               AlwaysStoppedAnimation<Color>(Colors.blue),
//                         )
//                       : Text("Process Complete!"),
//                   actions: <Widget>[
//                     TextButton(
//                       child: Text('Close'),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//             _startProcess();
//           },
//           child: Text('Start Process'),
//         ),
//       ),
//     );
//   }
// }

// class TestScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Linear Progress Bar in Dialog'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) {
//                 return Dialog(
//                   child: Container(
//                     height: 150.0,
//                     padding: EdgeInsets.all(20.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         LinearProgressIndicator(
//                           backgroundColor: Colors.grey,
//                           color: Colors.grey,
//                           minHeight: 20,
//                         ),
//                         SizedBox(height: 20.0),
//                         Text('Loading...'),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//             // Simulate loading process with delay
//             Future.delayed(Duration(seconds: 3), () {
//               Navigator.of(context).pop(); // Close the dialog
//             });
//           },
//           child: Text('Show Dialog'),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:wheatwise/features/records/delete_record/bloc/delete_record_bloc.dart';
// import 'package:wheatwise/features/records/delete_record/bloc/delete_record_state.dart';
// import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
// import 'package:wheatwise/features/records/recent_records/bloc/bloc.dart';
// import 'package:wheatwise/features/records/recent_records/components/diagnoisis_card.dart';
// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
// import 'package:wheatwise/features/theme/bloc/theme_state.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   String selectedFilterCategory = 'All';
//   bool showFilterCategories = false;

//   Widget recordFilterHeader() {
//     return Container(
//       height: 38,
//       margin: const EdgeInsets.only(bottom: 10),

//       // height: 40,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: <Widget>[
//           buildFilterCategoryButton('All'),
//           const SizedBox(width: 5),
//           buildFilterCategoryButton('Bookmarks'),
//           const SizedBox(width: 5),
//           buildFilterCategoryButton('Uploads'),
//           const SizedBox(width: 5),
//           buildFilterCategoryButton('Local'),
//           const SizedBox(width: 5),
//           buildFilterCategoryButton('Reviewed'),
//           const SizedBox(width: 5),
//           buildFilterCategoryButton('Unreviewed'),
//         ],
//       ),
//     );
//   }

//   Widget buildFilterCategoryButton(String category) {
//     return InkWell(
//       splashColor: Colors.grey[100],
//       onTap: () {
//         setState(() {
//           selectedFilterCategory =
//               category == selectedFilterCategory ? 'All' : category;
//         });
//       },
//       child: Container(
//         // height: 50,
//         width: 110,
//         decoration: BoxDecoration(
//           color: selectedFilterCategory == category
//               ? Colors.grey[900]
//               : Colors.grey[500],
//           borderRadius: const BorderRadius.all(Radius.circular(12.0)),
//         ),
//         child: Center(
//           child: Text(
//             category,
//             style: const TextStyle(
//               color: Colors.white,
//               fontFamily: 'SF-Pro-Text',
//               fontSize: 15.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<Diagnosis> filterRecords(List<Diagnosis> records) {
//     switch (selectedFilterCategory) {
//       case 'Bookmarks':
//         return records
//             .where((element) => element.isBookmarked == true)
//             .toList();
//       case 'Uploads':
//         return records
//             .where((element) => element.isUploaded == true)
//             // .where((element) => element.isServerDiagnosed == true)
//             .toList();
//       case 'Local':
//         return records
//             .where((element) => element.isUploaded == false)
//             // .where((element) => element.isServerDiagnosed == false)
//             .toList();
//       case 'Reviewed':
//         return records
//             .where((element) => element.manualDiagnosis != '')
//             .toList();
//       case 'Unreviewed':
//         return records
//             .where((element) => element.manualDiagnosis == '')
//             .toList();
//       default:
//         return records.toList();
//     }
//   }

//   Widget noRecordFound() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 180,
//             child: Image.asset('assets/images/no-file-found.png'),
//           ),
//           Text(
//             'No records found',
//             style: TextStyle(
//               fontFamily: 'Clash Display',
//               fontSize: 17,
//               fontWeight: FontWeight.w400,
//               color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, themeState) {
//         return SafeArea(
//           child: Scaffold(
//             backgroundColor: themeState is DarkThemeState
//                 ? BlocProvider.of<ThemeBloc>(context).state.backgroundColor
//                 : const Color.fromARGB(255, 243, 243, 243),
//             appBar: AppBar(
//               elevation: 0,
//               title: Text(
//                 'Records',
//                 style: TextStyle(
//                     fontFamily: 'Clash Display',
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600,
//                     color: BlocProvider.of<ThemeBloc>(context).state.textColor),
//               ),
//               actions: [
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       showFilterCategories = !showFilterCategories;
//                     });
//                   },
//                   icon: SvgPicture.asset(
//                     'assets/icons/filter-by-icon.svg',
//                     color: showFilterCategories
//                         ? const Color.fromRGBO(248, 147, 29, 1)
//                         : Colors.grey,
//                     width: 20,
//                     height: 20,
//                   ),
//                 )
//               ],
//             ),
//             body: BlocBuilder<RecentRecordsBloc, RecentRecordsState>(
//                 builder: (context, recentRecordsState) {
//               if (recentRecordsState is RecentRecordsLoadingState) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (recentRecordsState is RecentRecordsFailureState) {
//                 return Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Failed to get recent images',
//                           style: TextStyle(
//                             fontFamily: 'Clash Display',
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 15),
//                         ElevatedButton(
//                           onPressed: () {
//                             BlocProvider.of<RecentRecordsBloc>(context)
//                                 .add(LoadRecentRecordsEvent());
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 const Color.fromRGBO(248, 147, 29, 1)),
//                             minimumSize: MaterialStateProperty.all(
//                               const Size(double.infinity, 52),
//                             ),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                           ),
//                           child: const Text(
//                             "Retry",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: 'SF-Pro-Text',
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.w800,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               } else if (recentRecordsState is RecentRecordsSuccessState) {
//                 return RefreshIndicator(
//                   onRefresh: () async {
//                     BlocProvider.of<RecentRecordsBloc>(context)
//                         .add(LoadRecentRecordsEvent());
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         top: 10, right: 16, left: 16, bottom: 10),
//                     // padding: const EdgeInsets.all(16.0),
//                     child: Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           if (showFilterCategories) recordFilterHeader(),
//                           recentRecordsState.diagnoses.isNotEmpty
//                               ? BlocConsumer<DeleteRecordBloc,
//                                   DeleteRecordState>(
//                                   listener: (context, deleteState) {
//                                     if (deleteState
//                                         is DeleteRecordSuccessState) {
//                                       BlocProvider.of<RecentRecordsBloc>(
//                                               context)
//                                           .add(LoadRecentRecordsEvent());
//                                     }
//                                   },
//                                   builder: (context, _) {
//                                     List<Diagnosis> recentRecords =
//                                         filterRecords(
//                                             recentRecordsState.diagnoses);

//                                     return Expanded(
//                                       child: recentRecords.isNotEmpty
//                                           ? ListView.builder(
//                                               itemCount: recentRecords.length,
//                                               itemBuilder:
//                                                   (BuildContext context,
//                                                       int index) {
//                                                 return DiagnosisCard(
//                                                   recentRecords[index],
//                                                   key: Key(recentRecords[index]
//                                                       .mobileId
//                                                       .toString()),
//                                                 );
//                                               },
//                                             )
//                                           : noRecordFound(),
//                                     );
//                                   },
//                                 )
//                               : noRecordFound(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               } else {
//                 BlocProvider.of<RecentRecordsBloc>(context)
//                     .add(LoadRecentRecordsEvent());
//                 return const Center(
//                   child: SpinKitCubeGrid(
//                     color: Color.fromRGBO(248, 147, 29, 1),
//                     size: 70.0,
//                   ),
//                 );
//               }
//             }),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
