
part of 'pdf_search_state_cubit.dart';

abstract class PdfSearchState {}

class PdfSearchInitial extends PdfSearchState {}

class PdfSearchLoaded extends PdfSearchState {
  final PdfTextSearchResult result;
  // نضيف متغير عشوائي لنجبر البلوك على تحديث الواجهة عند الضغط على التالي/السابق
  // لأن كائن result هو نفسه لا يتغير، فقط قيمه الداخلية تتغير
  final int refreshId; 

  PdfSearchLoaded(this.result, {this.refreshId = 0});
}