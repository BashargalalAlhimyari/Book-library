import 'package:clean_architecture/core/routes/authGuard.dart';
import 'package:clean_architecture/core/utils/token_storage.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/features/auth/presentaion/views/login.dart';
import 'package:clean_architecture/features/auth/presentaion/views/sign_up.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/views/details_page_view.dart';
import 'package:clean_architecture/features/home/presentaion/views/home_view.dart';
import 'package:clean_architecture/features/splash/presentaion/views/spalsh_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouters {
  static final routers = GoRouter(
    redirect: (context, state) => RouterAuthGuard.handleRedirect(context, state),

    routes: [
       GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: Routes.loginPage, builder: (context, state) => const LoginView()),
      GoRoute(path: Routes.signUp, builder: (context, state) => const SignUpView()),
      GoRoute(  path: Routes.homePage,builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: Routes.detailsPage,
        builder: (context, state) {
          BookEntity data = state.extra as BookEntity;
          return DetailsPageView(books: data);
        },
      ),
    ],
  );
}
