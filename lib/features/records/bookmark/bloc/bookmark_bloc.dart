import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_event.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_state.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(InitialBookmarkState()) {
    on<LoadBookmarkEvent>((event, emit) async {
      emit(BookmarkLoadingState());
      try {
        final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>('Diagnosis');
        final diagnosis = diagnosisBox.values
            .where((element) => element.isBookmarked == true)
            .toList()
            .reversed
            .toList();
        emit(BookmarkSuccessState(diagnosis));
      } catch (error) {
        print(error.toString());
        emit(BookmarkFailureState());
      }
    });

    on<AddBookmarkEvent>((event, emit) async {
      emit(AddBookmarkLoadingState());
      try {
        final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>('Diagnosis');
        event.diagnosis.isBookmarked = !(event.diagnosis.isBookmarked ?? false);

        int key = diagnosisBox.keys.firstWhere((key) {
          var value = diagnosisBox.get(key);
          return value != null && value.mobileId == event.diagnosis.mobileId;
        }, orElse: () => null);

        diagnosisBox.putAt(key, event.diagnosis);

        emit(AddBookmarkSuccessState(
            isBookmarked: event.diagnosis.isBookmarked!));
      } catch (error) {
        // print(error);
        emit(BookmarkFailureState());
      }
    });
  }
}
