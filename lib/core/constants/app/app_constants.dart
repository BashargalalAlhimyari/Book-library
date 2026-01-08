abstract class AppConstants {
  static const String appName = 'Bookly';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'A book reading application';

//localization
static const String defaultLocal='en';
static const List<String> supportedLocales = ['en', 'ar'];

//Hive box names
static const String boxAuthTokenName = 'auth_token_box';

//validation
static const int minPasswordLength = 6;
static const int maxPasswordLength = 20;

static const int minUsernameLength = 3;
static const int maxUsernameLength = 50;


//pagination
static const int itemsPerPage = 10;   // limit
static const int defaultPageNumber = 0;   
static const int maxPageSize = 100;


// api timeouts
static const Duration apiConnectTimeout = Duration(seconds: 10);
static const Duration apiReceiveTimeout = Duration(seconds: 10);

}