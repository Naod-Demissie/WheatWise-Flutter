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
        final bookmarks = diagnosisBox.values
            .where((element) => element.isBookmarked == true)
            .toList()
            .reversed
            .toList();
        emit(BookmarkSuccessState(bookmarks));
        diagnosisBox.close();
      } catch (e) {
        emit(BookmarkFailureState());
      }
    });

    on<AddBookmarkEvent>((event, emit) async {
      emit(AddBookmarkLoadingState());
      try {
        final Box<Diagnosis> diagnosisBox = Hive.box<Diagnosis>('Diagnosis');
        event.bookmark.isBookmarked = !(event.bookmark.isBookmarked ?? false);
        // event.bookmark.isBookmarked = !event.bookmark.isBookmarked!;
        // diagnosisBox.putAt(int.parse(event.bookmark.serverId),
        //     event.bookmark); // !changed to not nullable
        diagnosisBox.put(event.bookmark.mobileId, event.bookmark);
        emit(AddBookmarkSuccessState(
            isBookmarked:
                event.bookmark.isBookmarked!)); // !changed to not nullable
      } catch (error) {
        emit(BookmarkFailureState());
      }
    });
  }
}
