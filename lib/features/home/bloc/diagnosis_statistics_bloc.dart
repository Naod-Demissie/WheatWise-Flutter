import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_event.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_state.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

class DiagnosisStatisticsBloc
    extends Bloc<DiagnosisStatisticsEvent, DiagnosisStatisticsState> {
  DiagnosisStatisticsBloc() : super(InitialDiagnosisStatisticsState()) {
    on<LoadDiagnosisStatisticsEvent>((event, emit) async {
      emit(DiagnosisStatisticsLoadingState());
      try {
        // final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>("Diagnosis");
        // final List<String> diseaseList = [
        //   'Brown Rust',
        //   'Yellow Rust',
        //   'Septoria',
        //   'Mildew',
        //   'Healthy',
        // ];

        // Map<String, Map<String, int>> diagnosisStatistics = {
        //   'total': {},
        //   'Correct': {},
        //   'Incorrect': {},
        // };

        // for (String disease in diseaseList) {
        //   int count = diagnosisBox.values
        //       .where((diagnosis) => diagnosis.mobileDiagnosis == disease)
        //       .length;
        //   diagnosisStatistics['total']![disease] = count;

        //   int correctCount = 0;
        //   int incorrectCount = 0;

        //   for (int i = 0; i < diagnosisBox.length; i++) {
        //     Diagnosis diagnosis = diagnosisBox.getAt(i)!;

        //     if (diagnosis.mobileDiagnosis == disease) {
        //       if (diagnosis.manualDiagnosis != null &&
        //           diagnosis.manualDiagnosis == disease) {
        //         correctCount++;
        //       } else {
        //         incorrectCount++;
        //       }
        //     }
        //   }

        //   diagnosisStatistics['correct']![disease] = correctCount;
        //   diagnosisStatistics['incorrect']![disease] = incorrectCount;
        // }

        // final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>("Diagnosis");
        // final List<String> diseaseList = [
        //   'Brown Rust',
        //   'Yellow Rust',
        //   'Septoria',
        //   'Mildew',
        //   'Healthy',
        // ];

        // Map<String, Map<String, int>> diagnosisStatistics = {
        //   'total': {},
        //   'Correct': {},
        //   'Incorrect': {},
        // };

        // for (String disease in diseaseList) {
        //   int totalCount = 0;
        //   int correctCount = 0;
        //   int incorrectCount = 0;

        //   // Group diagnoses by model and manual diagnoses
        //   Map<String, List<Diagnosis>> groupedDiagnoses = groupBy(
        //       diagnosisBox.values, (diagnosis) => diagnosis.mobileDiagnosis);

        //   // Calculate counts
        //   if (groupedDiagnoses.containsKey(disease)) {
        //     totalCount = groupedDiagnoses[disease]!.length;
        //     correctCount = groupedDiagnoses[disease]!
        //         .where((diagnosis) => diagnosis.manualDiagnosis == disease)
        //         .length;
        //     incorrectCount = totalCount - correctCount;
        //   }

        //   diagnosisStatistics['total']![disease] = totalCount;
        //   diagnosisStatistics['Correct']![disease] = correctCount;
        //   diagnosisStatistics['Incorrect']![disease] = incorrectCount;
        // }

        final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>("Diagnosis");
        final List<String> diseaseList = [
          'Brown Rust',
          'Yellow Rust',
          'Septoria',
          'Mildew',
          'Healthy',
        ];

        Map<String, Map<String, int>> diagnosisStatistics = {
          'total': {},
          'Correct': {},
          'Incorrect': {},
          'Undiagnosed': {},
        };

        for (String disease in diseaseList) {
          int totalCount = 0;
          int correctCount = 0;
          int incorrectCount = 0;
          int undiagnosedCount = 0;

          // Group diagnoses by model and manual diagnoses
          Map<String, List<Diagnosis>> groupedDiagnoses = groupBy(
              diagnosisBox.values, (diagnosis) => diagnosis.mobileDiagnosis);

          // Calculate counts
          if (groupedDiagnoses.containsKey(disease)) {
            List<Diagnosis> diagnoses = groupedDiagnoses[disease]!;
            totalCount = diagnoses.length;
            correctCount = diagnoses
                .where((diagnosis) => diagnosis.manualDiagnosis == disease)
                .length;
            incorrectCount = diagnoses
                .where((diagnosis) =>
                    diagnosis.manualDiagnosis != disease &&
                    diagnosis.manualDiagnosis != '')
                .length;
            undiagnosedCount = diagnoses
                .where((diagnosis) => diagnosis.manualDiagnosis == '')
                .length;
          }

          diagnosisStatistics['total']![disease] = totalCount;
          diagnosisStatistics['Correct']![disease] = correctCount;
          diagnosisStatistics['Incorrect']![disease] = incorrectCount;
          diagnosisStatistics['Undiagnosed']![disease] = undiagnosedCount;
        }

        emit(DiagnosisStatisticsSuccessState(diagnosisStatistics));
      } catch (error) {
        print(error.toString());
        emit(DiagnosisStatisticsFailureState());
      }
    });
  }
}
