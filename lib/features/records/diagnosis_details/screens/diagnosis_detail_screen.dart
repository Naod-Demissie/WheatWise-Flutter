import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:readmore/readmore.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_bloc.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_event.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_state.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_state.dart';
import 'package:wheatwise/features/records/manual_diagnosis/bloc/manual_diagnosis_bloc.dart';
import 'package:wheatwise/features/records/manual_diagnosis/bloc/manual_diagnosis_event.dart';
import 'package:wheatwise/features/records/recent_records/bloc/recent_records_bloc.dart';
import 'package:wheatwise/features/records/recent_records/bloc/recent_records_event.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

class DiagnosisDetailScreen extends StatefulWidget {
  const DiagnosisDetailScreen({super.key});

  @override
  State<DiagnosisDetailScreen> createState() => _DiagnosisDetailScreenState();
}

class _DiagnosisDetailScreenState extends State<DiagnosisDetailScreen> {
  late final DiagnosisDetailBloc diagnosisDetailBloc;
  int? _selectedIndex;
  final List<String> diseaseList = [
    'Brown Rust',
    'Yellow Rust',
    'Septoria',
    'Mildew',
    'Healthy',
  ];

  @override
  void initState() {
    super.initState();
    diagnosisDetailBloc = BlocProvider.of<DiagnosisDetailBloc>(context);
  }

  Widget manualDiagnosisPopup(
    BuildContext context,
    StateSetter setState,
    String serverId,
    // String manualDiagnosis,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: const Text(
            'Add Manual Diagnosis',
            style: TextStyle(
              fontFamily: 'Clash Display',
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // List of Diseases
        SizedBox(
          height: 260,
          child: ListView.builder(
            itemCount: diseaseList.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 50,
                child: RadioListTile(
                  value: index,
                  groupValue: _selectedIndex,
                  title: Text(
                    diseaseList[index],
                    style: const TextStyle(
                      fontFamily: 'Clash Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onChanged: (int? value) {
                    setState(() {
                      if (_selectedIndex == value) {
                        _selectedIndex = null;
                      } else {
                        _selectedIndex = value;
                      }
                    });
                  },
                  toggleable: true,
                ),
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedIndex != null) {
                      BlocProvider.of<ManualDiagnosisBloc>(context).add(
                          ManualDiagnosisSave(
                              serverId: serverId,
                              manualDiagnosis: diseaseList[_selectedIndex!]));
                      Navigator.of(context).pop();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 0, 0, 0)),
                    minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.4, 52),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SF-Pro-Text',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(248, 147, 29, 1),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width * 0.4, 52),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SF-Pro-Text',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<DiagnosisDetailBloc, DiagnosisDetailState>(
      builder: (context, diagnosisState) {
        if (diagnosisState is DiagnosisDetailSuccessState) {
          return SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  BlocBuilder<BookmarkBloc, BookmarkState>(
                      builder: (context, bookmarkState) {
                    return Card(
                      elevation: 0,
                      shape: const CircleBorder(),
                      color: Colors.black.withOpacity(0.6),
                      margin: const EdgeInsets.all(10),
                      child: IconButton(
                        icon: diagnosisState.diagnosis.isBookmarked!
                            ? const Icon(Icons.bookmark_outline_outlined,
                                color: Color.fromRGBO(248, 147, 29, 1))
                            : const Icon(Icons.bookmark_outline_outlined,
                                color: Colors.grey),
                        onPressed: () {
                          BlocProvider.of<BookmarkBloc>(context).add(
                              AddBookmarkEvent(
                                  diagnosis: diagnosisState.diagnosis));
                          // BlocProvider.of<DiagnosisDetailBloc>(context).add(
                          //     LoadDiagnosisDetailEvent(
                          //         diagnosis: diagnosisState.diagnosis));

                          BlocProvider.of<RecentRecordsBloc>(context)
                              .add(LoadRecentRecordsEvent());
                        },
                      ),
                    );
                    // return Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    //     child: IconButton(
                    //       icon: diagnosisState.diagnosis.isBookmarked!
                    //           ? const Icon(Icons.bookmark_outline_outlined,
                    //               color: Color.fromRGBO(248, 147, 29, 1))
                    //           : const Icon(Icons.bookmark_outline_outlined,
                    //               color: Colors.grey),
                    //       onPressed: () {
                    //         BlocProvider.of<BookmarkBloc>(context).add(
                    //             AddBookmarkEvent(
                    //                 bookmark: diagnosisState.diagnosis));
                    //         BlocProvider.of<DiagnosisDetailBloc>(context).add(
                    //             LoadDiagnosisDetailEvent(
                    //                 diagnosis: diagnosisState.diagnosis));
                    //       },
                    //     ),
                    //   ),
                    // );
                  }),
                ],
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
                        // Icons.chevron_left_rounded,
                        Icons.close,
                        size: 20,
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // wheat image
                    GestureDetector(
                      onTap: () {
                        print(3);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImage(
                                imageFile:
                                    File(diagnosisState.diagnosis.filePath)),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: screenHeight * 0.35,
                        width: double.infinity,
                        child: Image.file(
                          File(diagnosisState.diagnosis.filePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Disease Title
                    Text(
                      diagnosisState.diagnosis.modelDiagnosis,
                      style: TextStyle(
                          fontFamily: 'Clash Display',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: BlocProvider.of<ThemeBloc>(context)
                              .state
                              .textColor),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                                fontFamily: 'Clash Display',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .textColor),
                          ),
                          const SizedBox(height: 5),
                          // Text(
                          //   diseases[diagnosisState
                          //       .diagnosis.modelDiagnosis]!['description']!,
                          //   style: const TextStyle(
                          //     fontFamily: 'Clash Display',
                          //     fontSize: 17,
                          //     fontWeight: FontWeight.w300,
                          //   ),
                          // ),
                          ReadMoreText(
                            diseases[diagnosisState.diagnosis.modelDiagnosis]![
                                'description']!,
                            trimMode: TrimMode.Line,
                            trimLines: 3,
                            // colorClickableText: Colors.pink,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            style: TextStyle(
                              fontFamily: 'Clash Display',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: BlocProvider.of<ThemeBloc>(context)
                                  .state
                                  .textColor,
                            ),
                            moreStyle: const TextStyle(
                              fontFamily: 'Clash Display',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Divider(height: 35, thickness: 0.4),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12))),
                                child: SvgPicture.asset(
                                  'assets/icons/shield-icon2.svg',
                                  color: Colors.blue.shade500,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mitigation',
                                      style: TextStyle(
                                        fontFamily: 'Clash Display',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            BlocProvider.of<ThemeBloc>(context)
                                                .state
                                                .textColor,
                                      ),
                                    ),
                                    Text(
                                      diseases[diagnosisState.diagnosis
                                          .modelDiagnosis]!['mitigation']!,
                                      style: TextStyle(
                                        fontFamily: 'Clash Display',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            BlocProvider.of<ThemeBloc>(context)
                                                .state
                                                .textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          // const SizedBox(height: 10),
                          const Divider(height: 35, thickness: 0.4),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12))),
                                child: SvgPicture.asset(
                                  'assets/icons/medicine-icon2.svg',
                                  color: Colors.green.shade500,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Medication',
                                      style: TextStyle(
                                        fontFamily: 'Clash Display',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            BlocProvider.of<ThemeBloc>(context)
                                                .state
                                                .textColor,
                                      ),
                                    ),
                                    Text(
                                      diseases[diagnosisState.diagnosis
                                          .modelDiagnosis]!['medication']!,
                                      style: TextStyle(
                                        fontFamily: 'Clash Display',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            BlocProvider.of<ThemeBloc>(context)
                                                .state
                                                .textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return manualDiagnosisPopup(
                                          context,
                                          setState,
                                          diagnosisState.diagnosis.serverId!);
                                      // diseaseList[_selectedIndex!]);
                                    },
                                  ));
                        },
                        // onPressed: () {
                        //   showModalBottomSheet(
                        //     context: context,
                        //     builder: (context) => manualDiagnosisPopup(context),
                        //   );
                        // },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 0, 0, 0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Add Manual Diagnosis',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SF-Pro-Text',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(248, 147, 29, 1),
                          ),
                          // minimumSize: MaterialStateProperty.all(
                          //   const Size(double.infinity, 52),
                          // ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Sync',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SF-Pro-Text',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (diagnosisState is DiagnosisDetailLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (diagnosisState is DiagnosisDetailFailureState) {
          return const Scaffold(
            body: Center(child: Text("Error Loading Detail Screen!")),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text("Initial State")),
          );
          // diagnosisDetailBloc.add(LoadDiagnosisDetailEvent(diagnosis: diagnosis));
          // return Center(child: CircularProgressIndicator());
        }

        // else {
        //   return const Scaffold(
        //       body: Center(child: Text("Error Loading Detail Screen!")));
        // }
      },
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final File imageFile;

  FullScreenImage({super.key, required this.imageFile});
  final PhotoViewController photoViewController = PhotoViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: PhotoView(
            controller: photoViewController,
            // enablePanAlways: true,
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            imageProvider: FileImage(imageFile),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 5.0,
            initialScale: PhotoViewComputedScale.contained,
          ),
        ),
      ),
    );
  }
}

Map<String, Map<String, String>> diseases = {
  'Yellow Rust': {
    'description':
        'Yellow rust, also known as stripe rust, is a fungal disease that affects wheat plants. It appears as yellowish stripes on the leaves, which can lead to reduced photosynthesis and lower yield.',
    'mitigation':
        'Use resistant wheat varieties, practice crop rotation, and apply fungicides when necessary.',
    'medication':
        'Fungicides containing active ingredients such as triazoles and strobilurins can be effective in controlling yellow rust. It is important to follow label instructions and apply at the correct timings.'
  },
  'Brown Rust': {
    'description':
        'Brown rust is a fungal disease that affects wheat plants, causing brownish rust pustules on the leaves. It can reduce photosynthesis and ultimately lead to lower yield.',
    'mitigation':
        'Use resistant wheat varieties, practice good crop hygiene, and apply fungicides preventatively.',
    'medication':
        'Fungicides containing active ingredients such as triazoles and strobilurins can be used to control brown rust. It is important to apply fungicides before the disease reaches damaging levels.'
  },
  'Septoria': {
    'description':
        'Septoria leaf blotch is a fungal disease that affects wheat plants, causing dark lesions with a yellow halo on the leaves. It can reduce photosynthesis and lower yield.',
    'mitigation':
        'Use resistant wheat varieties, practice crop rotation, and apply fungicides preventatively.',
    'medication':
        'Fungicides containing active ingredients such as azoles and strobilurins can be used to control septoria. It is important to apply fungicides at the right timings.'
  },
  'Mildew': {
    'description':
        'Powdery mildew is a fungal disease that affects wheat plants, appearing as white powdery spots on the leaves. It can reduce photosynthesis and lower yield.',
    'mitigation':
        'Use resistant wheat varieties, practice good air circulation, and apply fungicides when necessary.',
    'medication':
        'Fungicides containing active ingredients such as sulfur or potassium bicarbonate can be used to control powdery mildew. It is important to apply fungicides before the disease becomes severe.'
  },
};


// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:readmore/readmore.dart';
// import 'package:wheatwise/features/records/bookmark/bloc/bookmark_bloc.dart';
// import 'package:wheatwise/features/records/bookmark/bloc/bookmark_event.dart';
// import 'package:wheatwise/features/records/bookmark/bloc/bookmark_state.dart';
// import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
// import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_state.dart';
// import 'package:wheatwise/features/records/manual_diagnosis/bloc/manual_diagnosis_bloc.dart';
// import 'package:wheatwise/features/records/manual_diagnosis/bloc/manual_diagnosis_event.dart';
// import 'package:wheatwise/features/records/recent_records/bloc/recent_records_bloc.dart';
// import 'package:wheatwise/features/records/recent_records/bloc/recent_records_event.dart';

// class DiagnosisDetailScreen extends StatefulWidget {
//   const DiagnosisDetailScreen({super.key});

//   @override
//   State<DiagnosisDetailScreen> createState() => _DiagnosisDetailScreenState();
// }

// class _DiagnosisDetailScreenState extends State<DiagnosisDetailScreen> {
//   late final DiagnosisDetailBloc diagnosisDetailBloc;
//   int? _selectedIndex;
//   final List<String> diseaseList = [
//     'Brown Rust',
//     'Yellow Rust',
//     'Septoria',
//     'Mildew',
//     'Healthy',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     diagnosisDetailBloc = BlocProvider.of<DiagnosisDetailBloc>(context);
//   }

//   Widget manualDiagnosisPopup(
//     BuildContext context,
//     StateSetter setState,
//     String serverId,
//     // String manualDiagnosis,
//   ) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Title
//         Container(
//           margin: const EdgeInsets.only(top: 20, bottom: 10),
//           child: const Text(
//             'Add Manual Diagnosis',
//             style: TextStyle(
//               fontFamily: 'Clash Display',
//               fontSize: 19,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),

//         // List of Diseases
//         SizedBox(
//           height: 260,
//           child: ListView.builder(
//             itemCount: diseaseList.length,
//             itemBuilder: (BuildContext context, int index) {
//               return SizedBox(
//                 height: 50,
//                 child: RadioListTile(
//                   value: index,
//                   groupValue: _selectedIndex,
//                   title: Text(
//                     diseaseList[index],
//                     style: const TextStyle(
//                       fontFamily: 'Clash Display',
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   onChanged: (int? value) {
//                     setState(() {
//                       if (_selectedIndex == value) {
//                         _selectedIndex = null;
//                       } else {
//                         _selectedIndex = value;
//                       }
//                     });
//                   },
//                   toggleable: true,
//                 ),
//               );
//             },
//           ),
//         ),

//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   if (_selectedIndex != null) {
//                     BlocProvider.of<ManualDiagnosisBloc>(context).add(
//                         ManualDiagnosisSave(
//                             serverId: serverId,
//                             manualDiagnosis: diseaseList[_selectedIndex!]));
//                     Navigator.of(context).pop();
//                   }
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                       const Color.fromARGB(255, 0, 0, 0)),
//                   minimumSize: MaterialStateProperty.all(
//                     Size(MediaQuery.of(context).size.width * 0.4, 52),
//                   ),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//                 child: const Text(
//                   'Done',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'SF-Pro-Text',
//                     fontSize: 15.0,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                     const Color.fromRGBO(248, 147, 29, 1),
//                   ),
//                   minimumSize: MaterialStateProperty.all(
//                     Size(MediaQuery.of(context).size.width * 0.4, 52),
//                   ),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//                 child: const Text(
//                   'Cancel',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'SF-Pro-Text',
//                     fontSize: 15.0,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }


//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     // double screenWidth = MediaQuery.of(context).size.width;
//     return BlocBuilder<DiagnosisDetailBloc, DiagnosisDetailState>(
//       builder: (context, diagnosisState) {
//         if (diagnosisState is DiagnosisDetailSuccessState) {
//           return SafeArea(
//             child: Scaffold(
//               extendBodyBehindAppBar: true,
//               appBar: AppBar(
//                 elevation: 0,
//                 backgroundColor: Colors.transparent,
//                 actions: [
//                   BlocBuilder<BookmarkBloc, BookmarkState>(
//                       builder: (context, bookmarkState) {
//                     return Card(
//                       elevation: 0,
//                       shape: const CircleBorder(),
//                       color: Colors.black.withOpacity(0.6),
//                       margin: const EdgeInsets.all(10),
//                       child: IconButton(
//                         icon: diagnosisState.diagnosis.isBookmarked!
//                             ? const Icon(Icons.bookmark_outline_outlined,
//                                 color: Color.fromRGBO(248, 147, 29, 1))
//                             : const Icon(Icons.bookmark_outline_outlined,
//                                 color: Colors.grey),
//                         onPressed: () {
//                           BlocProvider.of<BookmarkBloc>(context).add(
//                               AddBookmarkEvent(
//                                   diagnosis: diagnosisState.diagnosis));
//                           // BlocProvider.of<DiagnosisDetailBloc>(context).add(
//                           //     LoadDiagnosisDetailEvent(
//                           //         diagnosis: diagnosisState.diagnosis));

//                           BlocProvider.of<RecentRecordsBloc>(context)
//                               .add(LoadRecentRecordsEvent());
//                         },
//                       ),
//                     );
//                     // return Padding(
//                     //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                     //   child: Padding(
//                     //     padding: const EdgeInsets.symmetric(horizontal: 3.0),
//                     //     child: IconButton(
//                     //       icon: diagnosisState.diagnosis.isBookmarked!
//                     //           ? const Icon(Icons.bookmark_outline_outlined,
//                     //               color: Color.fromRGBO(248, 147, 29, 1))
//                     //           : const Icon(Icons.bookmark_outline_outlined,
//                     //               color: Colors.grey),
//                     //       onPressed: () {
//                     //         BlocProvider.of<BookmarkBloc>(context).add(
//                     //             AddBookmarkEvent(
//                     //                 bookmark: diagnosisState.diagnosis));
//                     //         BlocProvider.of<DiagnosisDetailBloc>(context).add(
//                     //             LoadDiagnosisDetailEvent(
//                     //                 diagnosis: diagnosisState.diagnosis));
//                     //       },
//                     //     ),
//                     //   ),
//                     // );
//                   }),
//                 ],
//                 leading: Padding(
//                   padding: const EdgeInsets.only(left: 2.0),
//                   child: Card(
//                     elevation: 0,
//                     shape: const CircleBorder(),
//                     color: Colors.black.withOpacity(0.6),
//                     margin: const EdgeInsets.all(10),
//                     child: InkWell(
//                       onTap: () => Navigator.of(context).pop(),
//                       child: Icon(
//                         // Icons.chevron_left_rounded,
//                         Icons.close,
//                         size: 20,
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               body: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // wheat image
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => FullScreenImage(
//                                 imageFile:
//                                     File(diagnosisState.diagnosis.filePath)),
//                           ),
//                         );
//                       },
//                       child: SizedBox(
//                         height: screenHeight * 0.35,
//                         width: double.infinity,
//                         child: Image.file(
//                           File(diagnosisState.diagnosis.filePath),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),

//                     // Disease Title
//                     Text(
//                       diagnosisState.diagnosis.modelDiagnosis,
//                       style: const TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Description',
//                             style: TextStyle(
//                               fontFamily: 'Clash Display',
//                               fontSize: 22,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           // Text(
//                           //   diseases[diagnosisState
//                           //       .diagnosis.modelDiagnosis]!['description']!,
//                           //   style: const TextStyle(
//                           //     fontFamily: 'Clash Display',
//                           //     fontSize: 17,
//                           //     fontWeight: FontWeight.w300,
//                           //   ),
//                           // ),
//                           ReadMoreText(
//                             diseases[diagnosisState.diagnosis.modelDiagnosis]![
//                                 'description']!,
//                             trimMode: TrimMode.Line,
//                             trimLines: 3,
//                             // colorClickableText: Colors.pink,
//                             trimCollapsedText: 'Show more',
//                             trimExpandedText: 'Show less',
//                             style: const TextStyle(
//                               fontFamily: 'Clash Display',
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                             ),
//                             moreStyle: const TextStyle(
//                               fontFamily: 'Clash Display',
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const Divider(height: 35, thickness: 0.4),

//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                     color: Colors.blue.shade100,
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(12))),
//                                 child: SvgPicture.asset(
//                                   'assets/icons/shield-icon2.svg',
//                                   color: Colors.blue.shade500,
//                                   width: 30,
//                                   height: 30,
//                                 ),
//                               ),
//                               const SizedBox(width: 7),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Mitigation',
//                                       style: TextStyle(
//                                         fontFamily: 'Clash Display',
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     Text(
//                                       diseases[diagnosisState.diagnosis
//                                           .modelDiagnosis]!['mitigation']!,
//                                       style: const TextStyle(
//                                         fontFamily: 'Clash Display',
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                           // const SizedBox(height: 10),
//                           const Divider(height: 35, thickness: 0.4),

//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                     color: Colors.green.shade100,
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(12))),
//                                 child: SvgPicture.asset(
//                                   'assets/icons/medicine-icon2.svg',
//                                   color: Colors.green.shade500,
//                                   width: 30,
//                                   height: 30,
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Medication',
//                                       style: TextStyle(
//                                         fontFamily: 'Clash Display',
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     Text(
//                                       diseases[diagnosisState.diagnosis
//                                           .modelDiagnosis]!['medication']!,
//                                       style: const TextStyle(
//                                         fontFamily: 'Clash Display',
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               bottomNavigationBar: BottomAppBar(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         showModalBottomSheet(
//                             context: context,
//                             builder: (context) => StatefulBuilder(
//                                   builder: (BuildContext context,
//                                       StateSetter setState) {
//                                     return manualDiagnosisPopup(
//                                         context,
//                                         setState,
//                                         diagnosisState.diagnosis.serverId!);
//                                     // diseaseList[_selectedIndex!]);
//                                   },
//                                 ));
//                       },
//                       // onPressed: () {
//                       //   showModalBottomSheet(
//                       //     context: context,
//                       //     builder: (context) => manualDiagnosisPopup(context),
//                       //   );
//                       // },
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                             const Color.fromARGB(255, 0, 0, 0)),
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                       child: const Text(
//                         'Add Manual Diagnosis',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'SF-Pro-Text',
//                           fontSize: 15.0,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           const Color.fromRGBO(248, 147, 29, 1),
//                         ),
//                         // minimumSize: MaterialStateProperty.all(
//                         //   const Size(double.infinity, 52),
//                         // ),
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                       child: const Text(
//                         'Sync',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'SF-Pro-Text',
//                           fontSize: 15.0,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         } else if (diagnosisState is DiagnosisDetailLoadingState) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         } else if (diagnosisState is DiagnosisDetailFailureState) {
//           return const Scaffold(
//             body: Center(child: Text("Error Loading Detail Screen!")),
//           );
//         } else {
//           return const Scaffold(
//             body: Center(child: Text("Initial State")),
//           );
//           // diagnosisDetailBloc.add(LoadDiagnosisDetailEvent(diagnosis: diagnosis));
//           // return Center(child: CircularProgressIndicator());
//         }

//         // else {
//         //   return const Scaffold(
//         //       body: Center(child: Text("Error Loading Detail Screen!")));
//         // }
//       },
//     );
//   }
// }

// class FullScreenImage extends StatelessWidget {
//   final File imageFile;

//   FullScreenImage({super.key, required this.imageFile});
//   final PhotoViewController photoViewController = PhotoViewController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         child: Center(
//           child: Hero(
//             tag: 'expand',
//             child: PhotoView(
//               controller: photoViewController,
//               // enablePanAlways: true,
//               backgroundDecoration: const BoxDecoration(color: Colors.black),
//               imageProvider: FileImage(imageFile),
//               minScale: PhotoViewComputedScale.contained,
//               maxScale: PhotoViewComputedScale.covered * 5.0,
//               initialScale: PhotoViewComputedScale.contained,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Map<String, Map<String, String>> diseases = {
//   'Yellow Rust': {
//     'description':
//         'Yellow rust, also known as stripe rust, is a fungal disease that affects wheat plants. It appears as yellowish stripes on the leaves, which can lead to reduced photosynthesis and lower yield.',
//     'mitigation':
//         'Use resistant wheat varieties, practice crop rotation, and apply fungicides when necessary.',
//     'medication':
//         'Fungicides containing active ingredients such as triazoles and strobilurins can be effective in controlling yellow rust. It is important to follow label instructions and apply at the correct timings.'
//   },
//   'Brown Rust': {
//     'description':
//         'Brown rust is a fungal disease that affects wheat plants, causing brownish rust pustules on the leaves. It can reduce photosynthesis and ultimately lead to lower yield.',
//     'mitigation':
//         'Use resistant wheat varieties, practice good crop hygiene, and apply fungicides preventatively.',
//     'medication':
//         'Fungicides containing active ingredients such as triazoles and strobilurins can be used to control brown rust. It is important to apply fungicides before the disease reaches damaging levels.'
//   },
//   'Septoria': {
//     'description':
//         'Septoria leaf blotch is a fungal disease that affects wheat plants, causing dark lesions with a yellow halo on the leaves. It can reduce photosynthesis and lower yield.',
//     'mitigation':
//         'Use resistant wheat varieties, practice crop rotation, and apply fungicides preventatively.',
//     'medication':
//         'Fungicides containing active ingredients such as azoles and strobilurins can be used to control septoria. It is important to apply fungicides at the right timings.'
//   },
//   'Mildew': {
//     'description':
//         'Powdery mildew is a fungal disease that affects wheat plants, appearing as white powdery spots on the leaves. It can reduce photosynthesis and lower yield.',
//     'mitigation':
//         'Use resistant wheat varieties, practice good air circulation, and apply fungicides when necessary.',
//     'medication':
//         'Fungicides containing active ingredients such as sulfur or potassium bicarbonate can be used to control powdery mildew. It is important to apply fungicides before the disease becomes severe.'
//   },
// };
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:readmore/readmore.dart';
// import 'package:wheatwise/features/records/bookmark/bloc/bookmark_bloc.dart';
// import 'package:wheatwise/features/records/bookmark/bloc/bookmark_event.dart';
// import 'package:wheatwise/features/records/bookmark/bloc/bookmark_state.dart';
// import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
// import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_state.dart';
// import 'package:wheatwise/features/records/manual_diagnosis/bloc/manual_diagnosis_bloc.dart';
// import 'package:wheatwise/features/records/manual_diagnosis/bloc/manual_diagnosis_event.dart';
// import 'package:wheatwise/features/records/recent_records/bloc/recent_records_bloc.dart';
// import 'package:wheatwise/features/records/recent_records/bloc/recent_records_event.dart';

// class DiagnosisDetailScreen extends StatefulWidget {
//   const DiagnosisDetailScreen({super.key});

//   @override
//   State<DiagnosisDetailScreen> createState() => _DiagnosisDetailScreenState();
// }

// class _DiagnosisDetailScreenState extends State<DiagnosisDetailScreen> {
//   late final DiagnosisDetailBloc diagnosisDetailBloc;
//   int? _selectedIndex;
//   final List<String> diseaseList = [
//     'Brown Rust',
//     'Yellow Rust',
//     'Septoria',
//     'Mildew',
//     'Healthy',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     diagnosisDetailBloc = BlocProvider.of<DiagnosisDetailBloc>(context);
//   }

//   Widget manualDiagnosisPopup(
//     BuildContext context,
//     StateSetter setState,
//     String serverId,
//     // String manualDiagnosis,
//   ) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Title
//         Container(
//           margin: const EdgeInsets.only(top: 20, bottom: 10),
//           child: const Text(
//             'Add Manual Diagnosis',
//             style: TextStyle(
//               fontFamily: 'Clash Display',
//               fontSize: 19,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),

//         // List of Diseases
//         SizedBox(
//           height: 260,
//           child: ListView.builder(
//             itemCount: diseaseList.length,
//             itemBuilder: (BuildContext context, int index) {
//               return SizedBox(
//                 height: 50,
//                 child: RadioListTile(
//                   value: index,
//                   groupValue: _selectedIndex,
//                   title: Text(
//                     diseaseList[index],
//                     style: const TextStyle(
//                       fontFamily: 'Clash Display',
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   onChanged: (int? value) {
//                     setState(() {
//                       if (_selectedIndex == value) {
//                         _selectedIndex = null;
//                       } else {
//                         _selectedIndex = value;
//                       }
//                     });
//                   },
//                   toggleable: true,
//                 ),
//               );
//             },
//           ),
//         ),

//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   if (_selectedIndex != null) {
//                     BlocProvider.of<ManualDiagnosisBloc>(context).add(
//                         ManualDiagnosisSave(
//                             serverId: serverId,
//                             manualDiagnosis: diseaseList[_selectedIndex!]));
//                     Navigator.of(context).pop();
//                   }
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                       const Color.fromARGB(255, 0, 0, 0)),
//                   minimumSize: MaterialStateProperty.all(
//                     Size(MediaQuery.of(context).size.width * 0.4, 52),
//                   ),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//                 child: const Text(
//                   'Done',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'SF-Pro-Text',
//                     fontSize: 15.0,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                     const Color.fromRGBO(248, 147, 29, 1),
//                   ),
//                   minimumSize: MaterialStateProperty.all(
//                     Size(MediaQuery.of(context).size.width * 0.4, 52),
//                   ),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//                 child: const Text(
//                   'Cancel',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'SF-Pro-Text',
//                     fontSize: 15.0,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }


//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     // double screenWidth = MediaQuery.of(context).size.width;
//     return BlocBuilder<DiagnosisDetailBloc, DiagnosisDetailState>(
//       builder: (context, diagnosisState) {
//         if (diagnosisState is DiagnosisDetailSuccessState) {
//           return SafeArea(
//             child: Scaffold(
//               extendBodyBehindAppBar: true,
//               appBar: AppBar(
//                 elevation: 0,
//                 backgroundColor: Colors.transparent,
//                 actions: [
//                   BlocBuilder<BookmarkBloc, BookmarkState>(
//                       builder: (context, bookmarkState) {
//                     return Card(
//                       elevation: 0,
//                       shape: const CircleBorder(),
//                       color: Colors.black.withOpacity(0.6),
//                       margin: const EdgeInsets.all(10),
//                       child: IconButton(
//                         icon: diagnosisState.diagnosis.isBookmarked!
//                             ? const Icon(Icons.bookmark_outline_outlined,
//                                 color: Color.fromRGBO(248, 147, 29, 1))
//                             : const Icon(Icons.bookmark_outline_outlined,
//                                 color: Colors.grey),
//                         onPressed: () {
//                           BlocProvider.of<BookmarkBloc>(context).add(
//                               AddBookmarkEvent(
//                                   diagnosis: diagnosisState.diagnosis));
//                           // BlocProvider.of<DiagnosisDetailBloc>(context).add(
//                           //     LoadDiagnosisDetailEvent(
//                           //         diagnosis: diagnosisState.diagnosis));

//                           BlocProvider.of<RecentRecordsBloc>(context)
//                               .add(LoadRecentRecordsEvent());
//                         },
//                       ),
//                     );
//                     // return Padding(
//                     //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                     //   child: Padding(
//                     //     padding: const EdgeInsets.symmetric(horizontal: 3.0),
//                     //     child: IconButton(
//                     //       icon: diagnosisState.diagnosis.isBookmarked!
//                     //           ? const Icon(Icons.bookmark_outline_outlined,
//                     //               color: Color.fromRGBO(248, 147, 29, 1))
//                     //           : const Icon(Icons.bookmark_outline_outlined,
//                     //               color: Colors.grey),
//                     //       onPressed: () {
//                     //         BlocProvider.of<BookmarkBloc>(context).add(
//                     //             AddBookmarkEvent(
//                     //                 bookmark: diagnosisState.diagnosis));
//                     //         BlocProvider.of<DiagnosisDetailBloc>(context).add(
//                     //             LoadDiagnosisDetailEvent(
//                     //                 diagnosis: diagnosisState.diagnosis));
//                     //       },
//                     //     ),
//                     //   ),
//                     // );
//                   }),
//                 ],
//                 leading: Padding(
//                   padding: const EdgeInsets.only(left: 2.0),
//                   child: Card(
//                     elevation: 0,
//                     shape: const CircleBorder(),
//                     color: Colors.black.withOpacity(0.6),
//                     margin: const EdgeInsets.all(10),
//                     child: InkWell(
//                       onTap: () => Navigator.of(context).pop(),
//                       child: Icon(
//                         // Icons.chevron_left_rounded,
//                         Icons.close,
//                         size: 20,
//                         color: Colors.grey.shade200,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               body: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // wheat image
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => FullScreenImage(
//                                 imageFile:
//                                     File(diagnosisState.diagnosis.filePath)),
//                           ),
//                         );
//                       },
//                       child: SizedBox(
//                         height: screenHeight * 0.35,
//                         width: double.infinity,
//                         child: Image.file(
//                           File(diagnosisState.diagnosis.filePath),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),

//                     // Disease Title
//                     Text(
//                       diagnosisState.diagnosis.modelDiagnosis,
//                       style: const TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Description',
//                             style: TextStyle(
//                               fontFamily: 'Clash Display',
//                               fontSize: 22,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           // Text(
//                           //   diseases[diagnosisState
//                           //       .diagnosis.modelDiagnosis]!['description']!,
//                           //   style: const TextStyle(
//                           //     fontFamily: 'Clash Display',
//                           //     fontSize: 17,
//                           //     fontWeight: FontWeight.w300,
//                           //   ),
//                           // ),
//                           ReadMoreText(
//                             diseases[diagnosisState.diagnosis.modelDiagnosis]![
//                                 'description']!,
//                             trimMode: TrimMode.Line,
//                             trimLines: 3,
//                             // colorClickableText: Colors.pink,
//                             trimCollapsedText: 'Show more',
//                             trimExpandedText: 'Show less',
//                             style: const TextStyle(
//                               fontFamily: 'Clash Display',
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                             ),
//                             moreStyle: const TextStyle(
//                               fontFamily: 'Clash Display',
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const Divider(height: 35, thickness: 0.4),

//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                     color: Colors.blue.shade100,
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(12))),
//                                 child: SvgPicture.asset(
//                                   'assets/icons/shield-icon2.svg',
//                                   color: Colors.blue.shade500,
//                                   width: 30,
//                                   height: 30,
//                                 ),
//                               ),
//                               const SizedBox(width: 7),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Mitigation',
//                                       style: TextStyle(
//                                         fontFamily: 'Clash Display',
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     Text(
//                                       diseases[diagnosisState.diagnosis
//                                           .modelDiagnosis]!['mitigation']!,
//                                       style: const TextStyle(
//                                         fontFamily: 'Clash Display',
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                           // const SizedBox(height: 10),
//                           const Divider(height: 35, thickness: 0.4),

//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                     color: Colors.green.shade100,
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(12))),
//                                 child: SvgPicture.asset(
//                                   'assets/icons/medicine-icon2.svg',
//                                   color: Colors.green.shade500,
//                                   width: 30,
//                                   height: 30,
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Medication',
//                                       style: TextStyle(
//                                         fontFamily: 'Clash Display',
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     Text(
//                                       diseases[diagnosisState.diagnosis
//                                           .modelDiagnosis]!['medication']!,
//                                       style: const TextStyle(
//                                         fontFamily: 'Clash Display',
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               bottomNavigationBar: BottomAppBar(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         showModalBottomSheet(
//                             context: context,
//                             builder: (context) => StatefulBuilder(
//                                   builder: (BuildContext context,
//                                       StateSetter setState) {
//                                     return manualDiagnosisPopup(
//                                         context,
//                                         setState,
//                                         diagnosisState.diagnosis.serverId!);
//                                     // diseaseList[_selectedIndex!]);
//                                   },
//                                 ));
//                       },
//                       // onPressed: () {
//                       //   showModalBottomSheet(
//                       //     context: context,
//                       //     builder: (context) => manualDiagnosisPopup(context),
//                       //   );
//                       // },
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                             const Color.fromARGB(255, 0, 0, 0)),
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                       child: const Text(
//                         'Add Manual Diagnosis',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'SF-Pro-Text',
//                           fontSize: 15.0,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           const Color.fromRGBO(248, 147, 29, 1),
//                         ),
//                         // minimumSize: MaterialStateProperty.all(
//                         //   const Size(double.infinity, 52),
//                         // ),
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                       child: const Text(
//                         'Sync',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'SF-Pro-Text',
//                           fontSize: 15.0,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         } else if (diagnosisState is DiagnosisDetailLoadingState) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         } else if (diagnosisState is DiagnosisDetailFailureState) {
//           return const Scaffold(
//             body: Center(child: Text("Error Loading Detail Screen!")),
//           );
//         } else {
//           return const Scaffold(
//             body: Center(child: Text("Initial State")),
//           );
//           // diagnosisDetailBloc.add(LoadDiagnosisDetailEvent(diagnosis: diagnosis));
//           // return Center(child: CircularProgressIndicator());
//         }

//         // else {
//         //   return const Scaffold(
//         //       body: Center(child: Text("Error Loading Detail Screen!")));
//         // }
//       },
//     );
//   }
// }

// class FullScreenImage extends StatelessWidget {
//   final File imageFile;

//   FullScreenImage({super.key, required this.imageFile});
//   final PhotoViewController photoViewController = PhotoViewController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         child: Center(
//           child: Hero(
//             tag: 'expand',
//             child: PhotoView(
//               controller: photoViewController,
//               // enablePanAlways: true,
//               backgroundDecoration: const BoxDecoration(color: Colors.black),
//               imageProvider: FileImage(imageFile),
//               minScale: PhotoViewComputedScale.contained,
//               maxScale: PhotoViewComputedScale.covered * 5.0,
//               initialScale: PhotoViewComputedScale.contained,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Map<String, Map<String, String>> diseases = {
//   'Yellow Rust': {
//     'description':
//         'Yellow rust, also known as stripe rust, is a fungal disease that affects wheat plants. It appears as yellowish stripes on the leaves, which can lead to reduced photosynthesis and lower yield.',
//     'mitigation':
//         'Use resistant wheat varieties, practice crop rotation, and apply fungicides when necessary.',
//     'medication':
//         'Fungicides containing active ingredients such as triazoles and strobilurins can be effective in controlling yellow rust. It is important to follow label instructions and apply at the correct timings.'
//   },
//   'Brown Rust': {
//     'description':
//         'Brown rust is a fungal disease that affects wheat plants, causing brownish rust pustules on the leaves. It can reduce photosynthesis and ultimately lead to lower yield.',
//     'mitigation':
//         'Use resistant wheat varieties, practice good crop hygiene, and apply fungicides preventatively.',
//     'medication':
//         'Fungicides containing active ingredients such as triazoles and strobilurins can be used to control brown rust. It is important to apply fungicides before the disease reaches damaging levels.'
//   },
//   'Septoria': {
//     'description':
//         'Septoria leaf blotch is a fungal disease that affects wheat plants, causing dark lesions with a yellow halo on the leaves. It can reduce photosynthesis and lower yield.',
//     'mitigation':
//         'Use resistant wheat varieties, practice crop rotation, and apply fungicides preventatively.',
//     'medication':
//         'Fungicides containing active ingredients such as azoles and strobilurins can be used to control septoria. It is important to apply fungicides at the right timings.'
//   },
//   'Mildew': {
//     'description':
//         'Powdery mildew is a fungal disease that affects wheat plants, appearing as white powdery spots on the leaves. It can reduce photosynthesis and lower yield.',
//     'mitigation':
//         'Use resistant wheat varieties, practice good air circulation, and apply fungicides when necessary.',
//     'medication':
//         'Fungicides containing active ingredients such as sulfur or potassium bicarbonate can be used to control powdery mildew. It is important to apply fungicides before the disease becomes severe.'
//   },
// };
