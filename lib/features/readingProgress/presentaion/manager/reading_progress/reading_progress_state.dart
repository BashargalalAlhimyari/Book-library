part of 'reading_progress_cubit.dart';

@immutable
abstract class ReadingProgressState {}

class ReadingProgressInitial extends ReadingProgressState {}

class ReadingProgressLoading extends ReadingProgressState {}

class ReadingProgressSuccess extends ReadingProgressState {
  final ReadingProgressEntity? lastReadBook;
  ReadingProgressSuccess(this.lastReadBook);
}

class ReadingProgressFailure extends ReadingProgressState {
  final String errMessage;
  ReadingProgressFailure(this.errMessage);
}
