import 'dart:async'; // Required for Completer
import 'dart:io';
import 'package:clean_architecture/core/widgets/shared/custom_snack_bar.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:clean_architecture/features/readingProgress/presentaion/manager/reading_progress/reading_progress_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:clean_architecture/core/di/service_locator.dart';
import 'package:clean_architecture/core/theme/colors.dart';

class PdfViewerPage extends StatefulWidget {
  final String filePath;
  final int bookId;
  final int userId;
  final int? currentPage;
  final BookEntity? book;

  const PdfViewerPage({
    super.key,
    required this.filePath,
    required this.bookId,
    required this.userId, 
     this.currentPage =0,
     this.book,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  // 1. Controller to programmatically control the PDF (Jump pages)
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  int? pages = 0;
  int? currentPage;
  bool isReady = false;
  String errorMessage = '';

  // 2. State for Night Mode
  bool isNightMode = false;

  @override
  void initState() {
    super.initState();
    currentPage = widget.currentPage;
  }

  @override
  void dispose() {
    _saveProgress(isDisposing: true);
    super.dispose();
  }

  void _saveProgress({bool isDisposing = false}) {
    if (pages == null || pages == 0 || currentPage == null) return;

    final progress = ReadingProgressEntity(
      userId: widget.userId,
      bookId: widget.bookId,
      currentPage: currentPage!,
      totalPages: pages!,
      isCompleted: currentPage == pages! - 1,
      book: widget.book,
    );

    try {
      getIt<ReadingProgressCubit>().saveProgress(progress);
      if (!isDisposing && mounted) {
        CustomSnackBar.show(
          context: context,
          message: "Progress saved successfully",
        );
      }
    } catch (e) {
      if (!isDisposing && mounted) {
        CustomSnackBar.show(
          context: context,
          message: "Failed to save progress",
          isError: true,
        );
      }
    }
  }

  // 3. Helper to Show "Go To Page" Dialog
  Future<void> _showGoToPageDialog(PDFViewController controller) async {
    final TextEditingController pageController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Go to Page"),
          content: TextField(
            controller: pageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter page number (1 - $pages)",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final int? page = int.tryParse(pageController.text);
                if (page != null && page > 0 && page <= pages!) {
                  // PDFView pages are 0-indexed, so we subtract 1
                  controller.setPage(page - 1);
                  Navigator.pop(context);
                }
              },
              child: const Text("Go"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
        backgroundColor: AppColors.primary,
        actions: [
          // --- Feature A: Night Mode Toggle ---
          IconButton(
            icon: Icon(isNightMode ? Icons.wb_sunny : Icons.nightlight_round),
            tooltip: "Toggle Night Mode",
            onPressed: () {
              setState(() {
                isNightMode = !isNightMode;
              });
            },
          ),
          // --- Feature B: Manual Save ---
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveProgress(isDisposing: false),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.filePath,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: widget.currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
            // --- Feature A: Enable Night Mode in View ---
            nightMode: isNightMode,

            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
              // Complete the controller so we can use it later
              _controller.complete(pdfViewController);
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                currentPage = page;
              });
            },
          ),

          // Loading Indicator
          if (errorMessage.isEmpty && !isReady)
            const Center(child: CircularProgressIndicator()),

          // Error Message
          if (errorMessage.isNotEmpty) Center(child: Text(errorMessage)),

          // --- Feature C: Floating Page Indicator & Navigator ---
          if (isReady)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: FutureBuilder<PDFViewController>(
                  future: _controller.future,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const SizedBox();

                    return GestureDetector(
                      onTap: () async {
                        await _showGoToPageDialog(snapshot.data!);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.menu_book,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              // +1 because pages start at 0 internally but we show 1 to user
                              "${(currentPage ?? 0) + 1} / $pages",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
