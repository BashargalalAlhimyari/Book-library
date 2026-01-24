import 'package:bloc/bloc.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/useCase/get_last_read_book_use_case.dart'
    show GetLastReadBookUseCase;
import '../../../domain/useCase/save_reading_progress_use_case.dart'
    show SaveReadingProgressUseCase;

part 'reading_progress_state.dart';

class ReadingProgressCubit extends Cubit<ReadingProgressState> {
  final SaveReadingProgressUseCase saveReadingProgressUseCase;
  final GetLastReadBookUseCase getLastReadBookUseCase;

  ReadingProgressCubit({
    required this.saveReadingProgressUseCase,
    required this.getLastReadBookUseCase,
  }) : super(ReadingProgressInitial());

  Future<void> saveProgress(ReadingProgressEntity progress) async {
    // We don't necessarily need to emit loading/success for background saving
    // unless we want to show a toast or something.
    // For now, we'll just call the use case.
    final result = await saveReadingProgressUseCase.call(progress);
    result.fold(
      (failure) => print("Failed to save progress: ${failure.message}"),
      (_) => print("Progress saved successfully"),
    );
    // Refresh last read book if needed
    fetchLastReadBook(progress.userId);
  }

  Future<void> fetchLastReadBook(int userId) async {
    emit(ReadingProgressLoading());
    final result = await getLastReadBookUseCase.call(userId);

    result.fold(
      (failure) => emit(ReadingProgressFailure(failure.message)),
      (progress) => emit(ReadingProgressSuccess(progress)),
    );
  }
}
