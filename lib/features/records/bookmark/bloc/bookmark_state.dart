import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class BookmarkState {}

class InitialBookmarkState extends BookmarkState {}

class BookmarkLoadingState extends BookmarkState {}

class AddBookmarkLoadingState extends BookmarkState {}

class AddBookmarkSuccessState extends BookmarkState {
  final bool isBookmarked;

  AddBookmarkSuccessState({required this.isBookmarked});
}

class BookmarkSuccessState extends BookmarkState {
  final List<Diagnosis> bookmarks;

  BookmarkSuccessState(this.bookmarks);
}

class BookmarkFailureState extends BookmarkState {}

class AddBookmarkFailureState extends BookmarkState {}
