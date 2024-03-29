import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_bloc.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_event.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_state.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_event.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_state.dart';

class DiagnosisDetailScreen extends StatefulWidget {
  const DiagnosisDetailScreen({super.key});

  @override
  State<DiagnosisDetailScreen> createState() => _DiagnosisDetailScreenState();
}

class _DiagnosisDetailScreenState extends State<DiagnosisDetailScreen> {
  late final DiagnosisDetailBloc diagnosisDetailBloc;
  @override
  void initState() {
    super.initState();
    diagnosisDetailBloc = BlocProvider.of<DiagnosisDetailBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: IconButton(
                            icon: diagnosisState
                                    .leafDetail.diagnosis.isBookmarked!
                                ? const Icon(Icons.bookmark,
                                    color: Color.fromRGBO(248, 147, 29, 1))
                                : const Icon(Icons.bookmark_outline_outlined,
                                    color: Colors.grey),
                            onPressed: () {
                              BlocProvider.of<BookmarkBloc>(context).add(
                                  AddBookmarkEvent(
                                      bookmark:
                                          diagnosisState.leafDetail.diagnosis));
                              BlocProvider.of<DiagnosisDetailBloc>(context).add(
                                  LoadDiagnosisDetailEvent(
                                      diagnosis:
                                          diagnosisState.leafDetail.diagnosis));
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ],
                leading: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Card(
                      elevation: 4,
                      shape: const CircleBorder(),
                      color: Colors.grey.shade300,
                      margin: const EdgeInsets.all(10),
                      child: Icon(
                        // Icons.chevron_left_rounded,
                        Icons.close,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (diagnosisState is DiagnosisDetailLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (diagnosisState is DiagnosisDetailFailureState) {
          print("Diagnosis state is in error: $diagnosisState");
          return const Scaffold(
            body: Center(child: Text("Error Loading Detail Screen!")),
          );
        } else {
          print("Diagnosis state is in errorrr: $diagnosisState");
          return const Scaffold(
            body: Center(child: Text("Error Loading Detail Screen!")),
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
