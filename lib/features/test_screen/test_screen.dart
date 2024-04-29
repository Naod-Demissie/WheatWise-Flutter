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





// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:wheatwise/features/records/delete_record/bloc/delete_record_bloc.dart';
// import 'package:wheatwise/features/records/delete_record/bloc/delete_record_event.dart';
// import 'package:wheatwise/features/records/delete_record/bloc/delete_record_state.dart';

// import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
// import 'package:wheatwise/features/records/recent_records/bloc/bloc.dart';

// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
// import 'package:wheatwise/features/theme/bloc/theme_state.dart';

// import 'dart:io';

// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:wheatwise/features/records/bookmark/bloc/bookmark_bloc.dart';
// import 'package:wheatwise/features/records/bookmark/bloc/bookmark_event.dart';
// import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
// import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_event.dart';
// import 'package:wheatwise/features/records/diagnosis_details/screens/diagnosis_detail_screen.dart';

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
//             .where((element) => element.isServerDiagnosed == true)
//             .toList();
//       case 'Local':
//         return records
//             .where((element) => element.isServerDiagnosed == false)
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
//                 BlocBuilder<RecentRecordsBloc, RecentRecordsState>(
//                     builder: (context, recentRecordsState) {
//                   if (recentRecordsState is RecentRecordsSuccessState &&
//                       recentRecordsState.diagnoses.isNotEmpty) {
//                     return IconButton(
//                       onPressed: () {
//                         setState(() {
//                           showFilterCategories = !showFilterCategories;
//                         });
//                       },
//                       icon: SvgPicture.asset(
//                         'assets/icons/filter-by-icon.svg',
//                         color: showFilterCategories
//                             ? const Color.fromRGBO(248, 147, 29, 1)
//                             : Colors.grey,
//                         width: 20,
//                         height: 20,
//                       ),
//                     );
//                   } else {
//                     return const SizedBox.shrink();
//                   }
//                 })
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
//                           if (showFilterCategories &&
//                               recentRecordsState.diagnoses.isNotEmpty)
//                             recordFilterHeader(),
//                           recentRecordsState.diagnoses.isNotEmpty
//                               ? BlocConsumer<DeleteRecordBloc,
//                                   DeleteRecordState>(
//                                   listener: (context, deleteState) {
//                                     if (deleteState
//                                         is DeleteRecordSuccessState) {
//                                       //! adjusted this part
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
//                                                 return Container(
//                                                   margin: const EdgeInsets.only(
//                                                       top: 5),
//                                                   child: ClipRRect(
//                                                     borderRadius:
//                                                         const BorderRadius.all(
//                                                             Radius.circular(
//                                                                 12)),
//                                                     child: Dismissible(
//                                                         key: UniqueKey(),
//                                                         background: Container(
//                                                             color: Colors
//                                                                 .redAccent),
//                                                         child: ClipRRect(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(12),
//                                                           child: DiagnosisCard(
//                                                               recentRecords[
//                                                                   index],
//                                                               key: Key(
//                                                                   recentRecords[
//                                                                           index]
//                                                                       .mobileId
//                                                                       .toString())),
//                                                         ),
//                                                         onDismissed:
//                                                             (direction) {
//                                                           BlocProvider.of<
//                                                                       DeleteRecordBloc>(
//                                                                   context)
//                                                               .add(StartDeleteRecordEvent(
//                                                                   diagnosis:
//                                                                       recentRecords[
//                                                                           index]));
//                                                           ScaffoldMessenger.of(
//                                                                   context)
//                                                               .showSnackBar(
//                                                                   const SnackBar(
//                                                                       content: Text(
//                                                                           'Record deleted')));

//                                                           // recentRecords
//                                                           //     .removeAt(index);
//                                                           setState(() {
//                                                             recentRecords
//                                                                 .removeAt(
//                                                                     index);
//                                                           });
//                                                         }),
//                                                   ),
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

// class DiagnosisCard extends StatefulWidget {
//   final Diagnosis diagnosis;
//   const DiagnosisCard(this.diagnosis, {super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _DiagnosisCardState createState() => _DiagnosisCardState();
// }

// class _DiagnosisCardState extends State<DiagnosisCard> {
//   late Future<XFile> _compressedImageFuture;

//   @override
//   void initState() {
//     super.initState();
//     _compressedImageFuture = compressImage();
//   }

//   Future<XFile> compressImage() async {
//     File file = File(widget.diagnosis.filePath);
//     final tempDir = await getTemporaryDirectory();
//     final targetPath =
//         '${tempDir.absolute.path}/optimized_image_${widget.diagnosis.fileName}';
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.path,
//       targetPath,
//       quality: 50,
//       minWidth: 100,
//       minHeight: 100,
//     );
//     return XFile(result!.path);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<XFile>(
//       future: _compressedImageFuture,
//       builder: (context, snapshot) {
//         return BlocBuilder<ThemeBloc, ThemeState>(
//           builder: (context, themeState) {
//             return SizedBox(
//               height: 105,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: BlocProvider.of<ThemeBloc>(context).state.cardColor,
//                   borderRadius: const BorderRadius.all(Radius.circular(12)),
//                   border: themeState is DarkThemeState
//                       ? Border.all(
//                           width: 0.7,
//                           color: Colors.grey.shade800,
//                         )
//                       : Border.all(
//                           width: 0.7,
//                           color: Colors.grey.shade400,
//                         ),
//                 ),
//                 child: InkWell(
//                   onTap: () {
//                     BlocProvider.of<DiagnosisDetailBloc>(context).add(
//                         LoadDiagnosisDetailEvent(diagnosis: widget.diagnosis));

//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: ((context) => const DiagnosisDetailScreen())));
//                   },
//                   child: Row(
//                     children: [
//                       // card image
//                       Expanded(
//                         flex: 2,
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(12),
//                             topRight: Radius.zero,
//                             bottomLeft: Radius.circular(12),
//                             bottomRight: Radius.zero,
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image:
//                                     FileImage(File(snapshot.data?.path ?? '')),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),

//                       Expanded(
//                         flex: 5,
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     '${widget.diagnosis.fileName.substring(0, 16)}...',
//                                     style: TextStyle(
//                                       fontFamily: 'Clash Display',
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w400,
//                                       color: BlocProvider.of<ThemeBloc>(context)
//                                           .state
//                                           .textColor,
//                                     ),
//                                   ),
//                                   Text(
//                                     DateFormat('yyyy-MM-dd HH:mm').format(
//                                       DateTime.fromMicrosecondsSinceEpoch(
//                                           widget.diagnosis.uploadTime),
//                                     ),
//                                     style: GoogleFonts.manrope(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 12,
//                                       color: BlocProvider.of<ThemeBloc>(context)
//                                           .state
//                                           .textColor
//                                           .withOpacity(0.5),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 10),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     widget.diagnosis.mobileDiagnosis,
//                                     style: TextStyle(
//                                       fontFamily: 'Clash Display',
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                       color: BlocProvider.of<ThemeBloc>(context)
//                                           .state
//                                           .textColor,
//                                     ),
//                                   ),
//                                   Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           BlocProvider.of<BookmarkBloc>(context)
//                                               .add(AddBookmarkEvent(
//                                                   diagnosis: widget.diagnosis));
//                                           BlocProvider.of<RecentRecordsBloc>(
//                                                   context)
//                                               .add(LoadRecentRecordsEvent());
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               right: 10.0),
//                                           child: Icon(
//                                             widget.diagnosis.isBookmarked!
//                                                 ? Icons.bookmark_outline
//                                                 : Icons.bookmark_outline,
//                                             color:
//                                                 widget.diagnosis.isBookmarked!
//                                                     ? const Color.fromRGBO(
//                                                         248, 147, 29, 1)
//                                                     : Colors.grey,
//                                           ),
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {},
//                                         child: Icon(
//                                           widget.diagnosis.isServerDiagnosed!
//                                               ? Icons.upload_rounded
//                                               : Icons.upload_rounded,
//                                           color: widget
//                                                   .diagnosis.isServerDiagnosed!
//                                               ? Colors.green
//                                               : Colors.grey,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
