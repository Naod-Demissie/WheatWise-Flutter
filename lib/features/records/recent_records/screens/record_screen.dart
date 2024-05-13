import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wheatwise/features/records/delete_record/bloc/delete_record_bloc.dart';
import 'package:wheatwise/features/records/delete_record/bloc/delete_record_state.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
import 'package:wheatwise/features/records/recent_records/bloc/bloc.dart';
import 'package:wheatwise/features/records/recent_records/components/diagnoisis_card.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_state.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  String selectedFilterCategory = 'All';
  bool showFilterCategories = false;

  Widget recordFilterHeader() {
    return Container(
      height: 38,
      margin: const EdgeInsets.only(bottom: 10),

      // height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          buildFilterCategoryButton('All'),
          const SizedBox(width: 5),
          buildFilterCategoryButton('Bookmarks'),
          const SizedBox(width: 5),
          buildFilterCategoryButton('Uploads'),
          const SizedBox(width: 5),
          buildFilterCategoryButton('Local'),
          const SizedBox(width: 5),
          buildFilterCategoryButton('Reviewed'),
          const SizedBox(width: 5),
          buildFilterCategoryButton('Unreviewed'),
        ],
      ),
    );
  }

  Widget buildFilterCategoryButton(String category) {
    return InkWell(
      splashColor: Colors.grey[100],
      onTap: () {
        setState(() {
          selectedFilterCategory =
              category == selectedFilterCategory ? 'All' : category;
        });
      },
      child: Container(
        // height: 50,
        width: 110,
        decoration: BoxDecoration(
          color: selectedFilterCategory == category
              ? Colors.grey[900]
              : Colors.grey[500],
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Center(
          child: Text(
            category,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'SF-Pro-Text',
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  List<Diagnosis> filterRecords(List<Diagnosis> records) {
    switch (selectedFilterCategory) {
      case 'Bookmarks':
        return records
            .where((element) => element.isBookmarked == true)
            .toList();
      case 'Uploads':
        return records
            .where((element) => element.isUploaded == true)
            // .where((element) => element.isServerDiagnosed == true)
            .toList();
      case 'Local':
        return records
            .where((element) => element.isUploaded == false)
            // .where((element) => element.isServerDiagnosed == false)
            .toList();
      case 'Reviewed':
        return records
            .where((element) => element.manualDiagnosis != '')
            .toList();
      case 'Unreviewed':
        return records
            .where((element) => element.manualDiagnosis == '')
            .toList();
      default:
        return records.toList();
    }
  }

  Widget noRecordFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 180,
            child: Image.asset('assets/images/no-file-found.png'),
          ),
          Text(
            'No records found',
            style: TextStyle(
              fontFamily: 'Clash Display',
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: BlocProvider.of<ThemeBloc>(context).state.textColor,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: themeState is DarkThemeState
                ? BlocProvider.of<ThemeBloc>(context).state.backgroundColor
                : const Color.fromARGB(255, 243, 243, 243),
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Records',
                style: TextStyle(
                    fontFamily: 'Clash Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: BlocProvider.of<ThemeBloc>(context).state.textColor),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      showFilterCategories = !showFilterCategories;
                    });
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/filter-by-icon.svg',
                    color: showFilterCategories
                        ? const Color.fromRGBO(248, 147, 29, 1)
                        : Colors.grey,
                    width: 20,
                    height: 20,
                  ),
                )
              ],
            ),
            body: BlocBuilder<RecentRecordsBloc, RecentRecordsState>(
                builder: (context, recentRecordsState) {
              if (recentRecordsState is RecentRecordsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (recentRecordsState is RecentRecordsFailureState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Failed to get recent images',
                          style: TextStyle(
                            fontFamily: 'Clash Display',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<RecentRecordsBloc>(context)
                                .add(LoadRecentRecordsEvent());
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(248, 147, 29, 1)),
                            minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 52),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Retry",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SF-Pro-Text',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (recentRecordsState is RecentRecordsSuccessState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<RecentRecordsBloc>(context)
                        .add(LoadRecentRecordsEvent());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 16, left: 16, bottom: 10),
                    // padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (showFilterCategories) recordFilterHeader(),
                          recentRecordsState.diagnoses.isNotEmpty
                              ? BlocConsumer<DeleteRecordBloc,
                                  DeleteRecordState>(
                                  listener: (context, deleteState) {
                                    if (deleteState
                                        is DeleteRecordSuccessState) {
                                      BlocProvider.of<RecentRecordsBloc>(
                                              context)
                                          .add(LoadRecentRecordsEvent());
                                    }
                                  },
                                  builder: (context, _) {
                                    List<Diagnosis> recentRecords =
                                        filterRecords(
                                            recentRecordsState.diagnoses);

                                    return Expanded(
                                      child: recentRecords.isNotEmpty
                                          ? ListView.builder(
                                              itemCount: recentRecords.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return DiagnosisCard(
                                                  recentRecords[index],
                                                  key: Key(recentRecords[index]
                                                      .mobileId
                                                      .toString()),
                                                );
                                              },
                                            )
                                          : noRecordFound(),
                                    );
                                  },
                                )
                              : noRecordFound(),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                BlocProvider.of<RecentRecordsBloc>(context)
                    .add(LoadRecentRecordsEvent());
                return const Center(
                  child: SpinKitCubeGrid(
                    color: Color.fromRGBO(248, 147, 29, 1),
                    size: 70.0,
                  ),
                );
              }
            }),
          ),
        );
      },
    );
  }
}




// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';

// import 'package:wheatwise/features/records/bookmark/bloc/bookmark_bloc.dart';
// import 'package:wheatwise/features/records/bookmark/bloc/bookmark_event.dart';
// import 'package:wheatwise/features/records/delete_record/bloc/delete_record_bloc.dart';
// import 'package:wheatwise/features/records/delete_record/bloc/delete_record_event.dart';
// import 'package:wheatwise/features/records/delete_record/bloc/delete_record_state.dart';
// import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
// import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_event.dart';
// import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
// import 'package:wheatwise/features/records/diagnosis_details/screens/diagnosis_detail_screen.dart';
// import 'package:wheatwise/features/records/recent_records/bloc/bloc.dart';
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
//                                     '${widget.diagnosis.fileName.length <= 16 ? widget.diagnosis.fileName : widget.diagnosis.fileName.substring(0, 16) + '...'}',
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
