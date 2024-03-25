import 'package:equatable/equatable.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();
}

class LoadBookmarkEvent extends BookmarkEvent {
  @override
  List<Object> get props => [];

  const LoadBookmarkEvent();
}

class AddBookmarkEvent extends BookmarkEvent {
  final Diagnosis bookmark;

  @override
  List<Object> get props => [bookmark];

  const AddBookmarkEvent({required this.bookmark});
}
