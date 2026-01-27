import 'package:flutter/material.dart';

class PdfPageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onTap;

  const PdfPageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.menu_book, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  "$currentPage / $totalPages",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}