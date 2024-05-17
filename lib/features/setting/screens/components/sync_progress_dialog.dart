// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:wheatwise/constants.dart';
// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

// showSyncDiagnosisDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: Container(
//             width: 120.0,
//             height: 120.0,
//             decoration: BoxDecoration(
//               color: BlocProvider.of<ThemeBloc>(context).state.cardColor,
//               borderRadius: BorderRadius.circular(4.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: LinearPercentIndicator(
//                 width: 90,
//                 animation: true,
//                 lineHeight: 6.0,
//                 animationDuration: 2000,
//                 percent: 0.9,
//                 progressColor: kPrimaryColor,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:wheatwise/constants.dart';
// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

// class SyncDiagnosisDialogBox extends StatelessWidget {
//   const SyncDiagnosisDialogBox({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return _showSyncDiagnosisDialog(context);
//   }

//   _showSyncDiagnosisDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: Container(
//             width: 120.0,
//             height: 120.0,
//             decoration: BoxDecoration(
//               color: BlocProvider.of<ThemeBloc>(context).state.cardColor,
//               borderRadius: BorderRadius.circular(4.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: LinearPercentIndicator(
//                 width: 90,
//                 animation: true,
//                 lineHeight: 6.0,
//                 animationDuration: 2000,
//                 percent: 0.9,
//                 progressColor: kPrimaryColor,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // latest
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:wheatwise/constants.dart';
// import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_bloc.dart';
// import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_event.dart';
// import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_state.dart';
// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
// import 'package:wheatwise/features/theme/bloc/theme_state.dart';

// class SyncDiagnosisDialogBox extends StatefulWidget {
//   const SyncDiagnosisDialogBox({super.key});

//   @override
//   State<SyncDiagnosisDialogBox> createState() => _SyncDiagnosisDialogBoxState();
// }

// class _SyncDiagnosisDialogBoxState extends State<SyncDiagnosisDialogBox> {
//   late double _progressPercent;

//   @override
//   void initState() {
//     super.initState();
//     _progressPercent = 0;
//     updateProgress();
//   }

//   void updateProgress() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, themeState) {
//         return BlocConsumer<SyncDiagnosisBloc, SyncDiagnosisState>(
//           listener: (context, syncDiagnosisState) {

//           },
//           builder: (context, syncDiagnosisState) {
//             return Container(
//               height: 43,
//               color: BlocProvider.of<ThemeBloc>(context).state.backgroundColor,
//               child: ListTile(
//                 onTap: () {
//                   BlocProvider.of<SyncDiagnosisBloc>(context)
//                       .add(const StartSyncAllDiagnosisEvent());
//                   // final progressPercent = syncDiagnosisState;
//                   showSyncDiagnosisDialog(context);
//                 },
//                 leading: SvgPicture.asset(
//                   'assets/icons/sync-data-icon3.svg',
//                   color: kPrimaryColor,
//                   width: 22,
//                   height: 22,
//                 ),
//                 title: Text(
//                   "Sync Data",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: 'Clash Display',
//                     fontWeight: FontWeight.w400,
//                     color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   showSyncDiagnosisDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return BlocBuilder<SyncDiagnosisBloc, SyncDiagnosisState>(
//           builder: (context, syncDiagnosisState) {
//             if (syncDiagnosisState is SyncDiagnosisLoadingState) {
//               return Center(
//                 child: Container(
//                   width: 120.0,
//                   height: 120.0,
//                   decoration: BoxDecoration(
//                     color: BlocProvider.of<ThemeBloc>(context).state.cardColor,
//                     borderRadius: BorderRadius.circular(4.0),
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Padding(
//                       padding: EdgeInsets.all(12.0),
//                       child: CupertinoActivityIndicator(
//                         color: kPrimaryColor,
//                         radius: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             } else if (syncDiagnosisState is SyncProgressState) {
//               final currentCount = syncDiagnosisState.currentCount;
//               final totalCounts = syncDiagnosisState.totalCounts;
//               final _progressPercent = currentCount / totalCounts;
//               return Center(
//                 child: Container(
//                   width: 120.0,
//                   height: 120.0,
//                   decoration: BoxDecoration(
//                     color: BlocProvider.of<ThemeBloc>(context).state.cardColor,
//                     borderRadius: BorderRadius.circular(4.0),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: LinearPercentIndicator(
//                       width: 90,
//                       animation: false,
//                       lineHeight: 6.0,
//                       animationDuration: 2000,
//                       percent: _progressPercent,
//                       progressColor: kPrimaryColor,
//                       barRadius: const Radius.circular(12),
//                     ),
//                   ),
//                 ),
//               );
//             } else if (syncDiagnosisState is SyncDiagnosisSuccessState) {
//               // Navigator.of(context).pop;
//               // ScaffoldMessenger.of(context).showSnackBar(
//               //   const SnackBar(
//               //     content: Text('SyncDiagnosisSuccessState'),
//               //   ),
//               // );
//               return Container();
//             } else if (syncDiagnosisState is NoInternetSyncDiagnosisState) {
//               // Navigator.of(context).pop;
//               // ScaffoldMessenger.of(context).showSnackBar(
//               //   const SnackBar(
//               //     content: Text('NoInternetSyncDiagnosisState'),
//               //   ),
//               // );
//               return Container();
//             } else {
//               // Navigator.of(context).pop;
//               // ScaffoldMessenger.of(context).showSnackBar(
//               //   const SnackBar(
//               //     content: Text('SyncDiagnosisFailureState'),
//               //   ),
//               // );
//               return Container();
//             }
//           },
//         );
//       },
//     );
//   }
// }
// latest with error
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:wheatwise/constants.dart';
import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_bloc.dart';
import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_event.dart';
import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_state.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_state.dart';

class SyncDiagnosisDialogBox extends StatefulWidget {
  const SyncDiagnosisDialogBox({super.key});

  @override
  State<SyncDiagnosisDialogBox> createState() => _SyncDiagnosisDialogBoxState();
}

class _SyncDiagnosisDialogBoxState extends State<SyncDiagnosisDialogBox> {
  final double progressPercent = 0.2;
  // late double _progressPercent;

  // @override
  // void initState() {
  //   super.initState();
  //   _progressPercent = 0;
  //   updateProgress();
  // }

  void updateProgress() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocConsumer<SyncDiagnosisBloc, SyncDiagnosisState>(
          listener: (context, syncDiagnosisState) {
            if (syncDiagnosisState is SyncDiagnosisSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Row(children: [
                    Icon(
                      Icons.check_circle_outline_outlined,
                    ),
                    SizedBox(width: 10),
                    Text('SyncDiagnosisSuccessState',
                        style: TextStyle(
                            fontFamily: 'Clash Display',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ]),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  showCloseIcon: true,
                  // duration: const Duration(milliseconds: 400),
                  elevation: 0,
                  backgroundColor: Colors.amber,
                  closeIconColor: Colors.black,
                ),
              );
            }
            if (syncDiagnosisState is NoInternetSyncDiagnosisState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(children: [
                    Icon(Icons.error_outline_rounded),
                    SizedBox(width: 10),
                    Text(
                      'NoInternetSyncDiagnosisState',
                      style: TextStyle(
                          fontFamily: 'Clash Display',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ]),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  showCloseIcon: true,
                  // duration: const Duration(seconds: 2),
                  backgroundColor: Colors.redAccent.shade200,
                  closeIconColor: Colors.black,
                ),
              );
            }
            if (syncDiagnosisState is SyncDiagnosisFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(children: [
                    Icon(Icons.error_outline_rounded),
                    SizedBox(width: 10),
                    Text(
                      'SyncDiagnosisFailureState',
                      style: TextStyle(
                          fontFamily: 'Clash Display',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ]),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  showCloseIcon: true,
                  // duration: const Duration(seconds: 2),
                  backgroundColor: Colors.redAccent.shade200,
                  closeIconColor: Colors.black,
                ),
              );
            }
          },
          builder: (context, state) {
            return Container(
              height: 43,
              color: BlocProvider.of<ThemeBloc>(context).state.backgroundColor,
              child: ListTile(
                onTap: () {
                  BlocProvider.of<SyncDiagnosisBloc>(context)
                      .add(const StartSyncAllDiagnosisEvent());
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocBuilder<SyncDiagnosisBloc, SyncDiagnosisState>(
                        builder: (context, syncDiagnosisState2) {
                          if (syncDiagnosisState2
                              is SyncDiagnosisLoadingState) {
                            return Center(
                              child: Container(
                                width: 120.0,
                                height: 120.0,
                                decoration: BoxDecoration(
                                  color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .cardColor,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: CupertinoActivityIndicator(
                                      color: kPrimaryColor,
                                      radius: 16,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (syncDiagnosisState2 is SyncProgressState) {
                            final currentCount =
                                syncDiagnosisState2.currentCount;
                            final totalCounts = syncDiagnosisState2.totalCounts;
                            final progressPercent = currentCount / totalCounts;
                            return Center(
                              child: Container(
                                width: 120.0,
                                height: 120.0,
                                decoration: BoxDecoration(
                                  color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .cardColor,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: LinearPercentIndicator(
                                    width: 90,
                                    animation: false,
                                    lineHeight: 6.0,
                                    animationDuration: 2000,
                                    percent: progressPercent,
                                    progressColor: kPrimaryColor,
                                    barRadius: const Radius.circular(12),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            Navigator.of(context).pop();
                            return Container();
                          }
                        },
                      );
                    },
                  );
                },
                leading: SvgPicture.asset(
                  'assets/icons/sync-data-icon3.svg',
                  color: kPrimaryColor,
                  width: 22,
                  height: 22,
                ),
                title: Text(
                  "Sync Data",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Clash Display',
                    fontWeight: FontWeight.w400,
                    color: BlocProvider.of<ThemeBloc>(context).state.textColor,
                  ),
                ),
              ),
            );
          },
          // builder: (context, state) {
          //   return Container(
          //     height: 43,
          //     color: BlocProvider.of<ThemeBloc>(context).state.backgroundColor,
          //     child: ListTile(
          //       onTap: () {
          //         BlocProvider.of<SyncDiagnosisBloc>(context)
          //             .add(const StartSyncAllDiagnosisEvent());
          //         // final progressPercent = syncDiagnosisState;
          //         showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return Center(
          //               child: Container(
          //                 width: 120.0,
          //                 height: 120.0,
          //                 decoration: BoxDecoration(
          //                   color:
          //                       BlocProvider.of<ThemeBloc>(context).state.cardColor,
          //                   borderRadius: BorderRadius.circular(4.0),
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(12.0),
          //                   child: LinearPercentIndicator(
          //                     width: 90,
          //                     animation: false,
          //                     lineHeight: 6.0,
          //                     animationDuration: 2000,
          //                     percent: _progressPercent,
          //                     progressColor: kPrimaryColor,
          //                     barRadius: const Radius.circular(12),
          //                   ),
          //                 ),
          //               ),
          //             );
          //           },
          //         );
          //       },
          //       leading: SvgPicture.asset(
          //         'assets/icons/sync-data-icon3.svg',
          //         color: kPrimaryColor,
          //         width: 22,
          //         height: 22,
          //       ),
          //       title: Text(
          //         "Sync Data",
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontFamily: 'Clash Display',
          //           fontWeight: FontWeight.w400,
          //           color: BlocProvider.of<ThemeBloc>(context).state.textColor,
          //         ),
          //       ),
          //     ),
          //   );
          // },
        );
      },
    );
  }
}
// // latest with error
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:wheatwise/constants.dart';
// import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_bloc.dart';
// import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_event.dart';
// import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_state.dart';
// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

// class SyncDiagnosisDialogBox extends StatefulWidget {
//   const SyncDiagnosisDialogBox({super.key});

//   @override
//   State<SyncDiagnosisDialogBox> createState() => _SyncDiagnosisDialogBoxState();
// }

// class _SyncDiagnosisDialogBoxState extends State<SyncDiagnosisDialogBox> {
//   late double _progressPercent;

//   @override
//   void initState() {
//     super.initState();
//     _progressPercent = 0;
//     updateProgress();
//   }

//   void updateProgress() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SyncDiagnosisBloc, SyncDiagnosisState>(
//       builder: (context, syncDiagnosisState) {
//         if (syncDiagnosisState is SyncDiagnosisLoadingState) {
//           return Container(
//             height: 43,
//             color: BlocProvider.of<ThemeBloc>(context).state.backgroundColor,
//             child: ListTile(
//               onTap: () {
//                 BlocProvider.of<SyncDiagnosisBloc>(context)
//                     .add(const StartSyncAllDiagnosisEvent());
//                 // final progressPercent = syncDiagnosisState;
//                 showSyncDiagnosisDialog(context, _progressPercent);
//               },
//               leading: SvgPicture.asset(
//                 'assets/icons/sync-data-icon3.svg',
//                 color: kPrimaryColor,
//                 width: 22,
//                 height: 22,
//               ),
//               title: Text(
//                 "Sync Data",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontFamily: 'Clash Display',
//                   fontWeight: FontWeight.w400,
//                   color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//                 ),
//               ),
//             ),
//           );
//         } else if (syncDiagnosisState is SyncProgressState) {
//           return Container(
//             height: 43,
//             color: BlocProvider.of<ThemeBloc>(context).state.backgroundColor,
//             child: ListTile(
//               onTap: () {
//                 BlocProvider.of<SyncDiagnosisBloc>(context)
//                     .add(const StartSyncAllDiagnosisEvent());
//                 final currentCount = syncDiagnosisState.currentCount;
//                 final totalCounts = syncDiagnosisState.totalCounts;
//                 final _progressPercent = currentCount / totalCounts;
//                 showSyncDiagnosisDialog(context, _progressPercent);
//               },
//               leading: SvgPicture.asset(
//                 'assets/icons/sync-data-icon3.svg',
//                 color: kPrimaryColor,
//                 width: 22,
//                 height: 22,
//               ),
//               title: Text(
//                 "Sync Data",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontFamily: 'Clash Display',
//                   fontWeight: FontWeight.w400,
//                   color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//                 ),
//               ),
//             ),
//           );
//         } else if (syncDiagnosisState is SyncDiagnosisSuccessState) {
//           Navigator.of(context).pop;
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('SyncDiagnosisSuccessState'),
//             ),
//           );
//           return Container();
//         } else if (syncDiagnosisState is NoInternetSyncDiagnosisState) {
//           Navigator.of(context).pop;
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('NoInternetSyncDiagnosisState'),
//             ),
//           );
//           return Container();
//         } else {
//           Navigator.of(context).pop;
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('SyncDiagnosisFailureState'),
//             ),
//           );
//           return Container();
//         }
//       },
//     );
//   }

//   showSyncDiagnosisDialog(BuildContext context, double progressPercent) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: Container(
//             width: 120.0,
//             height: 120.0,
//             decoration: BoxDecoration(
//               color: BlocProvider.of<ThemeBloc>(context).state.cardColor,
//               borderRadius: BorderRadius.circular(4.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: LinearPercentIndicator(
//                 width: 90,
//                 animation: false,
//                 lineHeight: 6.0,
//                 animationDuration: 2000,
//                 percent: progressPercent,
//                 progressColor: kPrimaryColor,
//                 barRadius: const Radius.circular(12),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:wheatwise/constants.dart';
// import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_bloc.dart';
// import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_event.dart';
// import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_state.dart';
// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

// class SyncDiagnosisDialogBox extends StatefulWidget {
//   const SyncDiagnosisDialogBox({super.key});

//   @override
//   State<SyncDiagnosisDialogBox> createState() => _SyncDiagnosisDialogBoxState();
// }

// class _SyncDiagnosisDialogBoxState extends State<SyncDiagnosisDialogBox> {
//   late double _progressPercent;

//   // late double _progressValue;

//   @override
//   void initState() {
//     super.initState();
//     _progressPercent = 0;
//     updateProgress();
//   }

//   void updateProgress() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SyncDiagnosisBloc, SyncDiagnosisState>(
//       builder: (context, syncDiagnosisState) {
//         if (syncDiagnosisState is SyncDiagnosisLoadingState) {
//           return Container(
//             height: 43,
//             color: BlocProvider.of<ThemeBloc>(context).state.backgroundColor,
//             child: ListTile(
//               onTap: () {
//                 BlocProvider.of<SyncDiagnosisBloc>(context)
//                     .add(const StartSyncAllDiagnosisEvent());
//                 // final progressPercent = syncDiagnosisState
//                 // showSyncDiagnosisDialog(context);
//               },
//               leading: SvgPicture.asset(
//                 'assets/icons/sync-data-icon3.svg',
//                 color: kPrimaryColor,
//                 width: 22,
//                 height: 22,
//               ),
//               title: Text(
//                 "Sync Data",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontFamily: 'Clash Display',
//                   fontWeight: FontWeight.w400,
//                   color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//                 ),
//               ),
//             ),
//           );
//         } else if (syncDiagnosisState is SyncProgressState) {
//           return Container(
//             height: 43,
//             color: BlocProvider.of<ThemeBloc>(context).state.backgroundColor,
//             child: ListTile(
//               onTap: () {
//                 BlocProvider.of<SyncDiagnosisBloc>(context)
//                     .add(const StartSyncAllDiagnosisEvent());
//                 // final progressPercent = syncDiagnosisState
//                 // showSyncDiagnosisDialog(context);
//               },
//               leading: SvgPicture.asset(
//                 'assets/icons/sync-data-icon3.svg',
//                 color: kPrimaryColor,
//                 width: 22,
//                 height: 22,
//               ),
//               title: Text(
//                 "Sync Data",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontFamily: 'Clash Display',
//                   fontWeight: FontWeight.w400,
//                   color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//                 ),
//               ),
//             ),
//           );
//         } else if (syncDiagnosisState is SyncDiagnosisSuccessState) {
//           Navigator.of(context).pop;
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('SyncDiagnosisSuccessState'),
//             ),
//           );
//         } else if (syncDiagnosisState is NoInternetSyncDiagnosisState) {
//           Navigator.of(context).pop;
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('NoInternetSyncDiagnosisState'),
//             ),
//           );
//         } else (syncDiagnosisState is SyncDiagnosisFailureState) {
//           Navigator.of(context).pop;
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('SyncDiagnosisFailureState'),
//             ),
//           );
//         };
//       },
//     );
//   }

//   showSyncDiagnosisDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: Container(
//             width: 120.0,
//             height: 120.0,
//             decoration: BoxDecoration(
//               color: BlocProvider.of<ThemeBloc>(context).state.cardColor,
//               borderRadius: BorderRadius.circular(4.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: LinearPercentIndicator(
//                 width: 90,
//                 animation: false,
//                 lineHeight: 6.0,
//                 animationDuration: 2000,
//                 percent: _progressValue,
//                 progressColor: kPrimaryColor,
//                 barRadius: const Radius.circular(12),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// //#################
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:wheatwise/constants.dart';
// import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_bloc.dart';
// import 'package:wheatwise/features/records/sync_diagnosis/bloc/sync_diagnosis_event.dart';
// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
// import 'package:wheatwise/features/theme/bloc/theme_state.dart';

// class SyncDiagnosisDialogBox extends StatefulWidget {
//   const SyncDiagnosisDialogBox({super.key});

//   @override
//   State<SyncDiagnosisDialogBox> createState() => _SyncDiagnosisDialogBoxState();
// }

// class _SyncDiagnosisDialogBoxState extends State<SyncDiagnosisDialogBox> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, state) {
//         return Container(
//           height: 43,
//           color: BlocProvider.of<ThemeBloc>(context).state.backgroundColor,
//           child: ListTile(
//             onTap: () {
//               BlocProvider.of<SyncDiagnosisBloc>(context)
//                   .add(const StartSyncAllDiagnosisEvent());
//               showSyncDiagnosisDialog(context);
//             },
//             leading: SvgPicture.asset(
//               'assets/icons/sync-data-icon3.svg',
//               color: kPrimaryColor,
//               width: 22,
//               height: 22,
//             ),
//             title: Text(
//               "Sync Data",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontFamily: 'Clash Display',
//                 fontWeight: FontWeight.w400,
//                 color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   showSyncDiagnosisDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return const SyncDiagnosisDialog();
//       },
//     );
//   }
// }

// class SyncDiagnosisDialog extends StatefulWidget {
//   const SyncDiagnosisDialog({super.key});

//   @override
//   State<SyncDiagnosisDialog> createState() => _SyncDiagnosisDialogState();
// }

// class _SyncDiagnosisDialogState extends State<SyncDiagnosisDialog> {
//   late double _progressValue;

//   @override
//   void initState() {
//     super.initState();
//     _progressValue = 0.0;
//     updateProgress();
//   }

//   void updateProgress() {
//     const oneSec = Duration(seconds: 1);
//     Timer.periodic(oneSec, (Timer t) {
//       setState(() {
//         _progressValue += 0.1;
//         if (_progressValue.toStringAsFixed(1) == '1.0') {
//           t.cancel();
//           return;
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: 120.0,
//         height: 120.0,
//         decoration: BoxDecoration(
//           color: BlocProvider.of<ThemeBloc>(context).state.cardColor,
//           borderRadius: BorderRadius.circular(4.0),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: LinearPercentIndicator(
//             width: 90,
//             animation: false,
//             lineHeight: 6.0,
//             animationDuration: 2000,
//             percent: _progressValue,
//             progressColor: kPrimaryColor,
//             barRadius: const Radius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:wheatwise/constants.dart';
// import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

// class SyncDiagnosisDialogBox extends StatefulWidget {
//   const SyncDiagnosisDialogBox({super.key});

//   @override
//   State<SyncDiagnosisDialogBox> createState() => _SyncDiagnosisDialogBoxState();
// }

// class _SyncDiagnosisDialogBoxState extends State<SyncDiagnosisDialogBox> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 43,
//       color: BlocProvider.of<ThemeBloc>(context).state.backgroundColor,
//       child: ListTile(
//         onTap: () {
//           showSyncDiagnosisDialog(context);
//         },
//         leading: SvgPicture.asset(
//           'assets/icons/sync-data-icon3.svg',
//           color: kPrimaryColor,
//           width: 22,
//           height: 22,
//         ),
//         title: Text(
//           "Sync Data",
//           style: TextStyle(
//             fontSize: 16,
//             fontFamily: 'Clash Display',
//             fontWeight: FontWeight.w400,
//             color: BlocProvider.of<ThemeBloc>(context).state.textColor,
//           ),
//         ),
//       ),
//     );
//   }

//   showSyncDiagnosisDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return const SyncDiagnosisDialog();
//       },
//     );
//   }
// }

// class SyncDiagnosisDialog extends StatefulWidget {
//   const SyncDiagnosisDialog({super.key});

//   @override
//   State<SyncDiagnosisDialog> createState() => _SyncDiagnosisDialogState();
// }

// class _SyncDiagnosisDialogState extends State<SyncDiagnosisDialog> {
//   late double _progressValue;

//   @override
//   void initState() {
//     super.initState();
//     _progressValue = 0.0;
//     updateProgress();
//   }

//   void updateProgress() {
//     const oneSec = Duration(seconds: 1);
//     Timer.periodic(oneSec, (Timer t) {
//       setState(() {
//         _progressValue += 0.1;

//         if (_progressValue.toStringAsFixed(1) == '1.0') {
//           t.cancel();
//           return;
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: 120.0,
//         height: 120.0,
//         decoration: BoxDecoration(
//           color: BlocProvider.of<ThemeBloc>(context).state.cardColor,
//           borderRadius: BorderRadius.circular(4.0),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: LinearPercentIndicator(
//             width: 90,
//             animation: false,
//             lineHeight: 6.0,
//             animationDuration: 2000,
//             percent: _progressValue,
//             progressColor: kPrimaryColor,
//             barRadius: const Radius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }
// }
