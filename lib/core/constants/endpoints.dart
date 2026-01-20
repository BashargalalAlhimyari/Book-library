
const PORT = '3000';
const IP = '127.0.0.1';

class EndPoint {
  static const String apiBaseUrl = 'http://$IP:3000';
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

  // للدوال التي تحتاج باراميترات، نستخدم دالة ثابتة
  static String bookDetails(int id) => '/books/$id';
}
