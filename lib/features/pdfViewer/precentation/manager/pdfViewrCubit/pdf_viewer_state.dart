class PdfViewerState {
  final int currentPage;
  final int totalPages;
  final bool isNightMode;

  const PdfViewerState({
    this.currentPage = 1,
    this.totalPages = 0,
    this.isNightMode = false,
  });

  // دالة لنسخ الحالة وتعديل جزء منها فقط
  PdfViewerState copyWith({
    int? currentPage,
    int? totalPages,
    bool? isNightMode,
  }) {
    return PdfViewerState(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isNightMode: isNightMode ?? this.isNightMode,
    );
  }
}