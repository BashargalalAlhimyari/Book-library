import 'package:clean_architecture/features/pdfViewer/precentation/manager/cubit/pdf_search_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PdfSearchResultWidget extends StatelessWidget {
  const PdfSearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ نستمع لحالة الكيوبت
    return BlocBuilder<PdfSearchCubit, PdfSearchState>(
      builder: (context, state) {
        // إذا لم يكن هناك بحث، نخفي الويدجت
        if (state is! PdfSearchLoaded || !state.result.hasResult) {
          return const SizedBox();
        }

        final result = state.result;
        final cubit = context.read<PdfSearchCubit>();

        return Positioned(
          top: 10,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black26)],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  '${result.currentInstanceIndex} / ${result.totalInstanceCount}',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 16),
                  onPressed: () => cubit.previousInstance(), // ✅
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () => cubit.nextInstance(), // ✅
                ),
                Container(height: 20, width: 1, color: Colors.grey),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => cubit.clearSearch(), // ✅
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}