import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

abstract class BookmarkEvent {
}

class LoadBookmarkEvent extends BookmarkEvent {
  LoadBookmarkEvent();
}

class AddBookmarkEvent extends BookmarkEvent {
  final Diagnosis diagnosis;

  AddBookmarkEvent({required this.diagnosis});
}
