import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_bloc.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_event.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_event.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
import 'package:wheatwise/features/records/diagnosis_details/screens/diagnosis_detail_screen.dart';
import 'package:wheatwise/features/records/recent_records/bloc/recent_records_bloc.dart';
import 'package:wheatwise/features/records/recent_records/bloc/recent_records_event.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_state.dart';

class DiagnosisCard extends StatefulWidget {
  final Diagnosis diagnosis;
  const DiagnosisCard(this.diagnosis, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DiagnosisCardState createState() => _DiagnosisCardState();
}

class _DiagnosisCardState extends State<DiagnosisCard> {
  late Future<XFile> _compressedImageFuture;

  @override
  void initState() {
    super.initState();
    _compressedImageFuture = compressImage();
  }

  Future<XFile> compressImage() async {
    File file = File(widget.diagnosis.filePath);
    String fileName = path.basename(file.path);
    final tempDir = await getTemporaryDirectory();
    final targetPath = '${tempDir.absolute.path}/optimized_$fileName';

    var result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 50,
      minWidth: 100,
      minHeight: 100,
    );
    return XFile(result!.path);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<XFile>(
      future: _compressedImageFuture,
      builder: (context, snapshot) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return SizedBox(
              height: 105,
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: BlocProvider.of<ThemeBloc>(context).state.cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: themeState is DarkThemeState
                      ? Border.all(
                          width: 0.7,
                          color: Colors.grey.shade800,
                        )
                      : Border.all(
                          width: 0.7,
                          color: Colors.grey.shade400,
                        ),
                ),
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<DiagnosisDetailBloc>(context).add(
                        LoadDiagnosisDetailEvent(diagnosis: widget.diagnosis));

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const DiagnosisDetailScreen())));
                  },
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
                                image: FileImage(File(snapshot.data?.path ??
                                    widget.diagnosis.filePath)),
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
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.diagnosis.fileName.length <= 16 ? widget.diagnosis.fileName : widget.diagnosis.fileName.substring(0, 16) + '...'}',
                                    style: TextStyle(
                                      fontFamily: 'Clash Display',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .textColor,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('yyyy-MM-dd HH:mm').format(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                          widget.diagnosis.uploadTime),
                                    ),
                                    style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .textColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.diagnosis.mobileDiagnosis,
                                    style: TextStyle(
                                      fontFamily: 'Clash Display',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: BlocProvider.of<ThemeBloc>(context)
                                          .state
                                          .textColor,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          BlocProvider.of<BookmarkBloc>(context)
                                              .add(AddBookmarkEvent(
                                                  diagnosis: widget.diagnosis));
                                          BlocProvider.of<RecentRecordsBloc>(
                                                  context)
                                              .add(LoadRecentRecordsEvent());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Icon(
                                            Icons.bookmark_outline,
                                            color:
                                                widget.diagnosis.isBookmarked!
                                                    ? const Color.fromRGBO(
                                                        248, 147, 29, 1)
                                                    : Colors.grey,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.cloud_upload_outlined,
                                          color: widget.diagnosis.isUploaded!
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
