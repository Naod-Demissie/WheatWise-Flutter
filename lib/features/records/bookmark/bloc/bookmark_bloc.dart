// import 'package:flutter_auth/domain/bookmarks/bookmarks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_event.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_state.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

// import 'dart:io';

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
        // await diagnosisBox.close();
      } catch (e) {
        emit(BookmarkFailureState());
      }
    });

    on<AddBookmarkEvent>((event, emit) async {
      emit(AddBookmarkLoadingState());
      try {
        final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>('Diagnosis');
        event.diagnosis.isBookmarked = !(event.diagnosis.isBookmarked ?? false);

        print('ddddddddddddddddddddd${int.parse(event.diagnosis.mobileId)}');
        // event.diagnosis.isBookmarked = !event.diagnosis.isBookmarked!;
        diagnosisBox.putAt(int.parse(event.diagnosis.mobileId),
            event.diagnosis); // !changed to not nullable
        // print(event.diagnosis.mobileId);
        // print(int.parse(event.diagnosis.serverId));
        print('eeeeeeeeeeeeeeeee');
        diagnosisBox.put(event.diagnosis.mobileId, event.diagnosis);
        emit(AddBookmarkSuccessState(
            isBookmarked:
                event.diagnosis.isBookmarked!)); // !changed to not nullable

        // await diagnosisBox.close();
      } catch (error) {
        print(error);
        emit(BookmarkFailureState());
      }
    });
  }
}
