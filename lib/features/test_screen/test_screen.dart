// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: ListView(
//           children: [
//             // Load a Lottie file from your assets
//             Lottie.asset('assets/LottieLogo1.json'),

//             // Load a Lottie file from a remote url
//             Lottie.network(
//                 'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),

//             // Load an animation and its images from a zip file
//             Lottie.asset('assets/lottiefiles/angel.zip'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_animated_icons/icons8.dart';
// import 'package:flutter_animated_icons/lottiefiles.dart';
// import 'package:flutter_animated_icons/useanimations.dart';
// import 'package:lottie/lottie.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> with TickerProviderStateMixin {
//   late AnimationController _settingController;
//   late AnimationController _favoriteController;
//   late AnimationController _menuController;
//   late AnimationController _bellController;
//   late AnimationController _bookController;

//   @override
//   void initState() {
//     super.initState();

//     _settingController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1));
//     _favoriteController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1));
//     _menuController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1));
//     _bellController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1))
//           ..repeat();
//     _bookController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1));
//   }

//   @override
//   void dispose() {
//     _settingController.dispose();
//     _favoriteController.dispose();
//     _menuController.dispose();
//     _bellController.dispose();
//     _bookController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: IconButton(
//             splashRadius: 10,
//             iconSize: 20,
//             onPressed: () {
//               _settingController.reset();
//               _settingController.forward();
//             },
//             icon: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child:
//                   Lottie.asset(Icons8.adjust, controller: _settingController),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(children: [
                  Icon(
                    // Icons.cloud_upload_outlined,
                    Icons.check_circle_outline_outlined,
                  ),
                  SizedBox(width: 10),
                  Text('This is a snackbar with an icon',
                      style: TextStyle(
                          fontFamily: 'Clash Display',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ]),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                ),
                showCloseIcon: true,
                // duration: const Duration(milliseconds: 400),
                elevation: 0,
                backgroundColor: Colors.amber,
                // backgroundColor: Colors.redAccent.shade200,
                closeIconColor: Colors.black,
              ),
            );
          },
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
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'SF-Pro-Text',
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
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
