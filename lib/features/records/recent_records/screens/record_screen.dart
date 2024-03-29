import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wheatwise/features/records/delete_record/bloc/delete_record_bloc.dart';
import 'package:wheatwise/features/records/delete_record/bloc/delete_record_state.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_event.dart';

import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
import 'package:wheatwise/features/records/diagnosis_details/screens/diagnosis_detail_screen.dart';
import 'package:wheatwise/features/records/recent_records/bloc/bloc.dart';

// class RecordScreen extends StatelessWidget {
//   const RecordScreen({super.key});

//   Widget noRecordFound() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: 180,
//           child: Image.asset('assets/images/no-file-found.png'),
//         ),
//         const Text(
//           'No records found',
//           style: TextStyle(
//             fontFamily: 'Clash Display',
//             fontSize: 16,
//             fontWeight: FontWeight.w300,
//           ),
//         )
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<RecentRecordsBloc, RecentRecordsState>(
//           builder: (context, recentRecordsState) {
//         if (recentRecordsState is RecentRecordsLoadingState) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (recentRecordsState is RecentRecordsFailureState) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Failed to get recent images'),
//                 ElevatedButton(
//                   onPressed: () {
//                     BlocProvider.of<RecentRecordsBloc>(context)
//                         .add(LoadRecentRecordsEvent());
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                         const Color.fromRGBO(248, 147, 29, 1)),
//                     minimumSize: MaterialStateProperty.all(
//                       const Size(double.infinity, 52),
//                     ),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                   child: const Text(
//                     "Retry",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'SF-Pro-Text',
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else if (recentRecordsState is RecentRecordsSuccessState) {
//           return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 recentRecordsState.diagnoses.isNotEmpty
//                     ? const Padding(
//                         padding: EdgeInsets.fromLTRB(8, 13, 8, 5),
//                         child: Center(
//                           child: Text(
//                             "Recently scanned",
//                             style: TextStyle(
//                                 fontSize: 22,
//                                 fontFamily: 'aerial',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       )
//                     : const SizedBox(),
//                 recentRecordsState.diagnoses.isNotEmpty
//                     ? BlocConsumer<DeleteRecordBloc, DeleteRecordState>(
//                         listener: (context, deleteState) {
//                         if (deleteState is DeleteRecordSuccessState) {
//                           BlocProvider.of<RecentRecordsBloc>(context)
//                               .add(LoadRecentRecordsEvent());
//                         }
//                       }, builder: (context, _) {
//                         return Expanded(
//                           child: ListView.builder(
//                             itemCount: recentRecordsState.diagnoses.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return DiagnosisCard(
//                                 recentRecordsState.diagnoses[index],
//                                 key: Key(recentRecordsState
//                                     .diagnoses[index].mobileId
//                                     .toString()),
//                               );
//                             },
//                           ),
//                         );
//                       })
//                     : noRecordFound()
//               ]);
//         } else {
//           return const Center(
//             child: SpinKitCubeGrid(
//               color: Color.fromRGBO(248, 147, 29, 1),
//               size: 70.0,
//             ),
//           );
//         }
//       }),
//     );
//   }
// }

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<RecentRecordsBloc>(context)
            .add(LoadRecentRecordsEvent());
      },
      child: Scaffold(
        body: BlocBuilder<RecentRecordsBloc, RecentRecordsState>(
            builder: (context, recentRecordsState) {
          if (recentRecordsState is RecentRecordsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (recentRecordsState is RecentRecordsFailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to get recent images'),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
            );
          } else if (recentRecordsState is RecentRecordsSuccessState) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  recentRecordsState.diagnoses.isNotEmpty
                      ? const Padding(
                          padding: EdgeInsets.fromLTRB(8, 13, 8, 5),
                          child: Center(
                            child: Text(
                              "Recently scanned",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'aerial',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  recentRecordsState.diagnoses.isNotEmpty
                      ? BlocConsumer<DeleteRecordBloc, DeleteRecordState>(
                          listener: (context, deleteState) {
                          if (deleteState is DeleteRecordSuccessState) {
                            BlocProvider.of<RecentRecordsBloc>(context)
                                .add(LoadRecentRecordsEvent());
                          }
                        }, builder: (context, _) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: recentRecordsState.diagnoses.length,
                              itemBuilder: (BuildContext context, int index) {
                                return DiagnosisCard(
                                  recentRecordsState.diagnoses[index],
                                  key: Key(recentRecordsState
                                      .diagnoses[index].mobileId
                                      .toString()),
                                );
                              },
                            ),
                          );
                        })
                      : noRecordFound()
                ]);
          } else {
            // return const Center(
            //   child: SpinKitCubeGrid(
            //     color: Color.fromRGBO(248, 147, 29, 1),
            //     size: 70.0,
            //   ),
            // );
            return const Center(
              child: Text('Initial State'),
            );
          }
        }),
      ),
    );
  }
}

// class RecordScreen extends StatelessWidget {
//   const RecordScreen({super.key});

//   Widget noRecordFound() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: 180,
//           child: Image.asset('assets/images/no-file-found.png'),
//         ),
//         const Text(
//           'No records found',
//           style: TextStyle(
//             fontFamily: 'Clash Display',
//             fontSize: 16,
//             fontWeight: FontWeight.w300,
//           ),
//         )
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         BlocProvider.of<RecentRecordsBloc>(context)
//             .add(LoadRecentRecordsEvent());
//       },
//       child: Scaffold(
//         body: BlocBuilder<RecentRecordsBloc, RecentRecordsEvent>(
//             builder: (context, recentRecordsState) {
//           if (recentRecordsState is RecentRecordsLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (recentRecordsState is RecentRecordsFailureState) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Failed to get recent images'),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (recentRecordsState is RecentRecordsLoadingState) {
//                       } else {
//                         BlocProvider.of<RecentRecordsBloc>(context)
//                             .add(LoadRecentRecordsEvent());
//                       }
//                     },
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all<Color>(
//                           const Color.fromRGBO(248, 147, 29, 1)),
//                       minimumSize: MaterialStateProperty.all(
//                         const Size(double.infinity, 52),
//                       ),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     child: const Text(
//                       "Retry",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'SF-Pro-Text',
//                         fontSize: 14.0,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else if (recentRecordsState is RecentRecordsSuccessState) {
//             return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   recentRecordsState.diagnoses.isNotEmpty
//                       ? const Padding(
//                           padding: EdgeInsets.fromLTRB(8, 13, 8, 5),
//                           child: Center(
//                             child: Text(
//                               "Recently scanned",
//                               style: TextStyle(
//                                   fontSize: 22,
//                                   fontFamily: 'aerial',
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         )
//                       : const SizedBox(),
//                   recentRecordsState.diagnoses.isNotEmpty
//                       ? BlocConsumer<DeleteRecordBloc, DeleteRecordState>(
//                           listener: (context, deleteState) {
//                           if (deleteState is DeleteRecordSuccessState) {
//                             BlocProvider.of<RecentRecordsBloc>(context)
//                                 .add(LoadRecentRecordsEvent());
//                           }
//                         }, builder: (context, _) {
//                           return Expanded(
//                             child: GridView.builder(
//                               gridDelegate:
//                                   const SliverGridDelegateWithMaxCrossAxisExtent(
//                                       maxCrossAxisExtent: 300,
//                                       mainAxisSpacing: 1,
//                                       crossAxisSpacing: 2,
//                                       mainAxisExtent: 220),
//                               itemCount: recentRecordsState.diagnoses.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return DiagnosisCard(
//                                   recentRecordsState.diagnoses[index],
//                                   key: Key(recentRecordsState
//                                       .diagnoses[index].mobileId
//                                       .toString()),
//                                 );
//                               },
//                             ),
//                           );
//                         })
//                       : noRecordFound()
//                 ]);
//           } else {
//             return const Center(
//               child: SpinKitCubeGrid(
//                 color: Color.fromRGBO(248, 147, 29, 1),
//                 size: 70.0,
//               ),
//             );
//           }
//         }),
//       ),
//     );
//   }
// }

// class RecordScreen extends StatelessWidget {
//   const RecordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(onRefresh: () async {
//       BlocProvider.of<RecentRecordsBloc>(context).add(LoadRecentRecordsEvent());

//     }, child: BlocBuilder<RecentRecordsBloc, RecentRecordsEvent>(
//         builder: (context, recentRecordsState) {
//       if (recentRecordsState is RecentRecordsLoadingState) {
//         return const Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       } else if (recentRecordsState is RecentRecordsFailureState) {
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text('Failed to get recent images'),
//               ElevatedButton(
//                 onPressed: () {
//                   if (recentRecordsState is RecentRecordsLoadingState) {
//                   } else {
//                     BlocProvider.of<RecentRecordsBloc>(context)
//                         .add(LoadRecentRecordsEvent());
//                   }
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                       const Color.fromRGBO(248, 147, 29, 1)),
//                   minimumSize: MaterialStateProperty.all(
//                     const Size(double.infinity, 52),
//                   ),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//                 child: const Text(
//                   "Retry",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'SF-Pro-Text',
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       } else if (recentRecordsState is RecentRecordsSuccessState) {
//         return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               recentRecordsState.diagnosis
//                   ? const Padding(
//                       padding: EdgeInsets.fromLTRB(8, 13, 8, 5),
//                       child: Center(
//                         child: Text(
//                           "Recently scanned",
//                           style: TextStyle(
//                               fontSize: 22,
//                               fontFamily: 'aerial',
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     )
//                   : const SizedBox(),
//               recentRecordsState
//                   ? BlocConsumer<DeleteRecordBloc,
//                           DeleteRecordState>(
//                       listener: (context, deleteState) {
//                       if (deleteState is DeleteRecordSuccessState) {
//                         BlocProvider.of<ScannedRecentBloc>(context)
//                             .add(LoadScannedUploadsEvent());
//                       }
//                     }, builder: (context, _) {
//                       return Expanded(
//                           child: GridView.builder(
//                         gridDelegate:
//                             const SliverGridDelegateWithMaxCrossAxisExtent(
//                                 maxCrossAxisExtent: 300,
//                                 mainAxisSpacing: 1,
//                                 crossAxisSpacing: 2,
//                                 mainAxisExtent: 220),
//                         itemCount: state.detectedLeafs.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return CardWidget(
//                             state.detectedLeafs[index],
//                             key: Key(state.detectedLeafs[index].coffeeLeafId
//                                 .toString()),
//                           );
//                         },
//                         // children: getCards(state.detectedLeafs),
//                       ));
//                     })
//                   : noRecordFound()
//             ]);
//       } else {
//                 return const Center(
//                     child: SpinKitCubeGrid(
//                   color: const Color.fromRGBO(248, 147, 29, 1),
//                   size: 70.0,
//                 ),);
//               }
//             }),);
//           }

//     })
//   }

// class RecordScreen extends StatelessWidget {
//   const RecordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Records',
//           style: TextStyle(
//             fontFamily: 'Clash Display',
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: Center(child: noRecordFound()),
//     );
//   }

//   Widget noRecordFound() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: 180,
//           child: Image.asset('assets/images/no-file-found.png'),
//         ),
//         const Text(
//           'No records found',
//           style: TextStyle(
//             fontFamily: 'Clash Display',
//             fontSize: 16,
//             fontWeight: FontWeight.w300,
//           ),
//         )
//       ],
//     );
//   }
// }

class DiagnosisCard extends StatelessWidget {
  final Diagnosis diagnosis;
  const DiagnosisCard(this.diagnosis, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: InkWell(
        onTap: () {
          BlocProvider.of<DiagnosisDetailBloc>(context)
              .add(LoadDiagnosisDetailEvent(diagnosis: diagnosis));

          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => const DiagnosisDetailScreen())));
        },
        child: Card(
          elevation: 4,
          surfaceTintColor: const Color.fromARGB(255, 211, 206, 206),
          child: Row(
            children: [
              // card image
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
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image name
                        Text(
                          '${diagnosis.fileName.substring(0, 8)}...',
                          style: const TextStyle(
                            fontFamily: 'Clash Display',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          // DateFormat('yyyy-MM-dd HH:mm').format(diagnosis.uploadTime),
                          DateFormat('yyyy-MM-dd HH:mm')
                              .format(DateTime.now()), //! change this
                          // style: const TextStyle(
                          //   fontFamily: 'SF-Pro-Text',
                          //   fontSize: 10,
                          //   fontWeight: FontWeight.w100,
                          // ),
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                          ),
                        ),
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
