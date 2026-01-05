
final PORT = '3000';
final IP = '10.36.84.22';

class EndPoint {
  static final String apiBaseUrl = 'http://$IP:$PORT';
  static final String baseUrl = '$apiBaseUrl/api';
  static final String loginEndpoint = '/auth/login';
  static final String registerEndpoint = '/auth/register';
  static final String booksEndpoint = '/books';
  static final String bookDetailsEndpoint = '/books/{id}';

  static final String uploadsBaseUrl = '$apiBaseUrl/uploads/';
}
