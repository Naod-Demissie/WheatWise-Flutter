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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;
  String? _profilePicPath;
  String? _firstName;

  List<String> assetPaths = [
    'assets/images/wheat-banner.jpg',
    'assets/images/wheat-banner2.jpg',
    'assets/images/wheat-banner3.jpg',
    'assets/images/wheat-banner4.jpg',
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
  // Future<CroppedFile?> cropImage(String filePath) async {
  //   return await imageCropper.cropImage(
  //     sourcePath: filePath,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     uiSettings: [
  //       AndroidUiSettings(
  //           toolbarTitle: 'Edit Photo',
  //           toolbarColor: Colors.black,
  //           toolbarWidgetColor: Colors.white,
  //           statusBarColor: Colors.black,
  //           backgroundColor: Colors.black,
  //           activeControlsWidgetColor: const Color.fromRGBO(248, 147, 29, 1),
  //           cropFrameColor: Colors.black,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       IOSUiSettings(
  //         title: 'Edit Photo',
  //       ),
  //     ],
  //   );
  // }

  Future<void> _loadModel() async {
    await Tflite.loadModel(
        model:
            "assets/model/MobilenetV3large__lr_0.0003__batch_32__dense512.tflite",
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
  // classifyImage(String filePath) async {
  //   List<dynamic>? recognitions = await Tflite.runModelOnImage(
  //     path: filePath,
  //     imageMean: 117.0,
  //     imageStd: 1.0,
  //     numResults: 5,
  //     threshold: 0,
  //     asynch: true,
  //   );

  //   if (recognitions == null) return [];
  //   return recognitions;
  // }

  String capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<MobileDiagnosisBloc, MobileDiagnosisState>(
      listener: (context, mobileDiagnosisState) async {
        if (mobileDiagnosisState is MobileDiagnosisSuccessState) {
          BlocProvider.of<DiagnosisDetailBloc>(context).add(
              LoadDiagnosisDetailEvent(
                  diagnosis: mobileDiagnosisState.diagnosis.last));

          BlocProvider.of<RecentRecordsBloc>(context)
              .add(LoadRecentRecordsEvent());
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const DiagnosisDetailScreen()));
        }
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
                              // color: Colors.black,
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
                      wheatwiseCard(assetPaths[2], themeState),
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
                      const SizedBox(height: 20),

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
          customElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final files =
                  await pickImage(source: ImageSource.gallery, multiple: false);

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
                      modelDiagnosis: recognitions[0]['label'],
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
                  //     modelDiagnosis: recognitions[0]['label'],
                  //   ),
                  // );
                }
              }
            },
            text: "Choose from Gallery",
            iconPath: 'assets/icons/scan-icon.svg',
          ),
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
                  //     modelDiagnosis: recognitions[0]['label'],
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
