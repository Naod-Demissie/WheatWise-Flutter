// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_event.dart';

import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
import 'package:wheatwise/features/records/diagnosis_details/screens/_diagnosdetail_screen.dart';

// class DiagnosisCard extends StatelessWidget {
//   final String imageUrl;
//   final String imageName;
//   final DateTime dateCreated;

//   DiagnosisCard({
//     required this.imageUrl,
//     required this.imageName,
//     required this.dateCreated,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.network(
//             imageUrl,
//             width: double.infinity,
//             height: 200,
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   imageName,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Created: ${dateCreated.toString()}',
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
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
