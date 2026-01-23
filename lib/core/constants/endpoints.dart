
const PORT = '3000';
const IP = '10.237.17.22';

class EndPoint {

  static const String apiBaseUrl = 'http://$IP:3000';
  static const String bookurl = '$apiBaseUrl/uploads/books/smart.pdf';
  static const String baseUrl = '$apiBaseUrl/api/v1';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String booksEndpoint = '/books';
  static const String trendingBooksEndpoint = '/books/trendingBooks';
  static const String newsBooksEndpoint = '/books/newsBooks';
  static const String quickReadEndpoint = '/books/quickRead';
  static const String topRatedBooksEndpoint = '/books/topRatedBooks';
  static const String bookDetailsEndpoint = '/books/{id}';
  static const String uploadsBaseUrl = '$apiBaseUrl/';
  static const String updateProgressEndpoint = '/reading-progress';
  static const String lastReadEndpoint = '/reading-progress';
  // للدوال التي تحتاج باراميترات، نستخدم دالة ثابتة
  static String bookDetails(int id) => '/books/$id';
}
