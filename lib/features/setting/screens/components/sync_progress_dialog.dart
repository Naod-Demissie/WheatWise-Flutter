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
  late double progressPercent;

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
        );
      },
    );
  }
}
