import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_bloc.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_event.dart';
import 'package:wheatwise/features/records/delete_record/bloc/delete_record_bloc.dart';
import 'package:wheatwise/features/records/delete_record/bloc/delete_record_state.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_event.dart';

import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
import 'package:wheatwise/features/records/diagnosis_details/screens/diagnosis_detail_screen.dart';
import 'package:wheatwise/features/records/recent_records/bloc/bloc.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  List<String> selectedFilterCategory = ['All'];
  bool showFilterCategories = false;

  Widget recordFilterHeader() {
    return SizedBox(
      height: 40,
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
        ],
      ),
    );
  }

  Widget buildFilterCategoryButton(String category) {
    return InkWell(
      splashColor: Colors.grey[100],
      onTap: () {
        if (category == "All") {
          selectedFilterCategory.clear();
          selectedFilterCategory.add("All");
        } else {
          if (selectedFilterCategory.length > 1 &&
              selectedFilterCategory.contains("All")) {
            selectedFilterCategory.clear();
            selectedFilterCategory.add(category);
          } else {
            if (selectedFilterCategory.contains("All")) {
              selectedFilterCategory.remove("All");
            }
            selectedFilterCategory.contains(category)
                ? selectedFilterCategory.remove(category)
                : selectedFilterCategory.add(category);

            if (selectedFilterCategory.length == 3) {
              selectedFilterCategory.clear();
              selectedFilterCategory.add("All");
            }
            if (selectedFilterCategory.isEmpty) {
              selectedFilterCategory.add("All");
            }
          }
        }
        setState(() {});
      },
      child: Container(
        height: 40,
        width: 110,
        decoration: BoxDecoration(
          color: selectedFilterCategory.contains(category)
              ? Colors.grey[900]
              : Colors.grey[500],
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Center(
          child: Text(category,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'SF-Pro-Text',
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              )),
        ),
      ),
    );
  }

  Widget noRecordFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 180,
          child: Image.asset('assets/images/no-file-found.png'),
        ),
        const Text(
          'No records found',
          style: TextStyle(
            fontFamily: 'Clash Display',
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }

//  RefreshIndicator(
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Records',
            style: TextStyle(
              fontFamily: 'Clash Display',
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  showFilterCategories = !showFilterCategories;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SvgPicture.asset(
                  'assets/icons/filter-by-icon.svg',
                  color: showFilterCategories
                      ? const Color.fromRGBO(248, 147, 29, 1)
                      : Colors.grey,
                  width: 20,
                  height: 20,
                ),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (showFilterCategories) recordFilterHeader(),
                        recentRecordsState.diagnoses.isNotEmpty
                            ? BlocConsumer<DeleteRecordBloc, DeleteRecordState>(
                                listener: (context, deleteState) {
                                if (deleteState is DeleteRecordSuccessState) {
                                  BlocProvider.of<RecentRecordsBloc>(context)
                                      .add(LoadRecentRecordsEvent());
                                }
                              }, builder: (context, _) {
                                // List<Diagnosis> recentRecords = [];

                                // if (selectedFilterCategory
                                //     .contains('Uploads')) {
                                //   if (selectedFilterCategory
                                //       .contains('Bookmarks')) {
                                //     recentRecords.addAll(recentRecordsState
                                //         .diagnoses
                                //         .where((element) =>
                                //             element.isServerDiagnosed == true &&
                                //             element.isBookmarked == true)
                                //         .toList());
                                //   } else {
                                //     recentRecords.addAll(recentRecordsState
                                //         .diagnoses
                                //         .where((element) =>
                                //             element.isServerDiagnosed == true &&
                                //             element.isBookmarked == false)
                                //         .toList());
                                //   }
                                // } else if (selectedFilterCategory
                                //     .contains('Local')) {
                                //   if (selectedFilterCategory
                                //       .contains('Bookmarks')) {
                                //     recentRecords.addAll(recentRecordsState
                                //         .diagnoses
                                //         .where((element) =>
                                //             element.isServerDiagnosed ==
                                //                 false &&
                                //             element.isBookmarked == true)
                                //         .toList());
                                //   } else {
                                //     recentRecords.addAll(recentRecordsState
                                //         .diagnoses
                                //         .where((element) =>
                                //             element.isServerDiagnosed ==
                                //                 false &&
                                //             element.isBookmarked == false)
                                //         .toList());
                                //   }
                                // } else {
                                //   recentRecords
                                //       .addAll(recentRecordsState.diagnoses);
                                // }

                                // recentRecords = recentRecords.toSet().toList();
                                List<Diagnosis> recentRecords = [];
                                if (selectedFilterCategory
                                    .contains('Bookmarks')) {
                                  recentRecords.addAll(recentRecordsState
                                      .diagnoses
                                      .where((element) =>
                                          element.isBookmarked == true)
                                      .toList());
                                } else if (selectedFilterCategory
                                    .contains('Uploads')) {
                                  recentRecords.addAll(recentRecordsState
                                      .diagnoses
                                      .where((element) =>
                                          element.isServerDiagnosed == true)
                                      .toList());
                                } else if (selectedFilterCategory
                                    .contains('Local')) {
                                  recentRecords.addAll(recentRecordsState
                                      .diagnoses
                                      .where((element) =>
                                          element.isServerDiagnosed == false)
                                      .toList());
                                } else {
                                  recentRecords
                                      .addAll(recentRecordsState.diagnoses);
                                }

                                // recentRecords = recentRecords
                                //     .fold(<Diagnosis>{},
                                //         (Set<Diagnosis> seen, Diagnosis value) {
                                //   if (recentRecords.indexOf(value) !=
                                //       recentRecords.lastIndexOf(value)) {
                                //     seen.add(value);
                                //   }
                                //   return seen;
                                // }).toList();

                                recentRecords = recentRecords.toSet().toList();

                                // List<Diagnosis> recentRecords = [];
                                // if (selectedFilterCategory
                                //     .contains('Bookmarks')) {
                                //   recentRecords.addAll(recentRecordsState
                                //       .diagnoses
                                //       .where((element) =>
                                //           element.isBookmarked == true &&
                                //           !selectedFilterCategory
                                //               .contains('Local')));
                                // } else if (selectedFilterCategory
                                //     .contains('Uploads')) {
                                //   recentRecords.addAll(recentRecordsState
                                //       .diagnoses
                                //       .where((element) =>
                                //           element.isServerDiagnosed == true &&
                                //           !selectedFilterCategory
                                //               .contains('Local')));
                                // } else if (selectedFilterCategory
                                //     .contains('Local')) {
                                //   recentRecords.addAll(recentRecordsState
                                //       .diagnoses
                                //       .where((element) =>
                                //           element.isServerDiagnosed == false));
                                // } else {
                                //   recentRecords
                                //       .addAll(recentRecordsState.diagnoses);
                                // }

                                // recentRecords = recentRecords.toSet().toList();

                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: recentRecords.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return DiagnosisCard(
                                        recentRecords[index],
                                        key: Key(recentRecords[index]
                                            .mobileId
                                            .toString()),
                                      );
                                    },
                                  ),
                                );
                                // return Expanded(
                                //   child: ListView.builder(
                                //     itemCount:
                                //         recentRecordsState.diagnoses.length,
                                //     itemBuilder:
                                //         (BuildContext context, int index) {
                                //       return DiagnosisCard(
                                //         recentRecordsState.diagnoses[index],
                                //         key: Key(recentRecordsState
                                //             .diagnoses[index].mobileId
                                //             .toString()),
                                //       );
                                //     },
                                //   ),
                                // );
                              })
                            : noRecordFound()
                      ]),
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
  }
}

class DiagnosisCard extends StatelessWidget {
  final Diagnosis diagnosis;
  const DiagnosisCard(this.diagnosis, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              width: 0.7,
              color: Colors.grey.shade400,
            )),
        child: InkWell(
          onTap: () {
            BlocProvider.of<DiagnosisDetailBloc>(context)
                .add(LoadDiagnosisDetailEvent(diagnosis: diagnosis));

            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const DiagnosisDetailScreen())));
          },
          child: Row(
            children: [
              //card image

              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.zero,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(diagnosis.filePath)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // image name and upload date
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // image name
                              '${diagnosis.fileName.substring(0, 16)}...',

                              style: const TextStyle(
                                fontFamily: 'Clash Display',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd HH:mm').format(
                                DateTime.fromMicrosecondsSinceEpoch(
                                    diagnosis.uploadTime),
                              ),
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              diagnosis.modelDiagnosis,
                              style: const TextStyle(
                                fontFamily: 'Clash Display',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<BookmarkBloc>(context).add(
                                        AddBookmarkEvent(diagnosis: diagnosis));
                                    BlocProvider.of<RecentRecordsBloc>(context)
                                        .add(LoadRecentRecordsEvent());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Icon(
                                      diagnosis.isBookmarked!
                                          ? Icons.bookmark_outline_outlined
                                          : Icons.bookmark_outline_outlined,
                                      color: diagnosis.isBookmarked!
                                          ? const Color.fromRGBO(
                                              248, 147, 29, 1)
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    diagnosis.isServerDiagnosed!
                                        ? Icons.upload_rounded
                                        : Icons.upload_rounded,
                                    color: diagnosis.isServerDiagnosed!
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
