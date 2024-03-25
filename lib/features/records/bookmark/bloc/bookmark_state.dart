import 'package:equatable/equatable.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();
}

class InitialBookmarkState extends BookmarkState {
  @override
  List<Object?> get props => [];
}

class BookmarkLoadingState extends BookmarkState {
  @override
  List<Object?> get props => [];
}

class AddBookmarkLoadingState extends BookmarkState {
  @override
  List<Object?> get props => [];
}

class AddBookmarkSuccessState extends BookmarkState {
  final bool bookmarked;

  const AddBookmarkSuccessState({required this.bookmarked});
  @override
  List<Object?> get props => [bookmarked];
}

class BookmarkSuccessState extends BookmarkState {
  final List<Diagnosis> bookmarks;

  const BookmarkSuccessState(this.bookmarks);

  @override
  List<Object?> get props => [bookmarks];
}

class BookmarkFailureState extends BookmarkState {
  @override
  List<Object?> get props => [];
}

class AddBookmarkFailureState extends BookmarkState {
  @override
  List<Object?> get props => [];
}
