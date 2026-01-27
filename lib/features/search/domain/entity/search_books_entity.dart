class SearchBooksEntity {
 final String bookId;

  final String title;

  final List<String> authors;

  final List<String> images; 

  final num price;

  SearchBooksEntity({required this.bookId, required this.title, required this.authors, required this.images, required this.price}); // نستخدم num ليقبل الفواصل (double) أو الأعداد الصحيحة (int)

}
