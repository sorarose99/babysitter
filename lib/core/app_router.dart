import 'package:babysit/pages/main_page.dart';
import 'package:go_router/go_router.dart';
import 'package:babysit/auth/chooseRoleScreen.dart';
import 'package:babysit/auth/login.dart';
import 'package:babysit/auth/signup.dart';
import 'package:babysit/auth/splash.dart';
import 'package:babysit/pages/home.dart';
import 'package:babysit/setters/find_sitter_screen.dart';
import 'package:babysit/setters/find_nurseries_screen.dart';
import 'package:babysit/setters/sitter_details_screen.dart';
import 'package:babysit/setters/children_screen.dart';

const String splashPath = '/';
const String chooseRolePath = '/choose-role';
const String signUpPath = '/sign-up';
const String loginPath = '/login';
const String homePath = '/home';
const String findSitterPath = '/find-sitter';
const String findNurseriesPath = '/find-nurseries';
const String sitterDetailsPath = '/sitter-details';
const String childrenPath = '/children';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: splashPath,
    routes: [
      GoRoute(
        path: splashPath,
        name: 'splash',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: homePath,
        name: 'home',
        builder: (context, state) => MainPage(child: HomeScreen()),
      ),
      GoRoute(
        path: chooseRolePath,
        name: 'choose-role',
        builder: (context, state) => MainPage(child: ChooseRoleScreen()),
      ),
      GoRoute(
        path: signUpPath,
        name: 'sign-up',
        builder: (context, state) {
          final role = state.uri.queryParameters['role'] ?? 'Parent';
          return MainPage(child: SignUpScreen(role: role));
        },
      ),
      GoRoute(
        path: loginPath,
        name: 'login',
        builder: (context, state) {
          final role = state.uri.queryParameters['role'] ?? 'Parent';
          return MainPage(child: LoginScreen(role: role));
        },
      ),
      GoRoute(
        path: findSitterPath,
        name: 'find-sitter',
        builder: (context, state) => MainPage(child: FindSitterScreen()),
      ),
      GoRoute(
        path: findNurseriesPath,
        name: 'find-nurseries',
        builder: (context, state) => MainPage(child: FindNurseriesScreen()),
      ),
      GoRoute(
        path: sitterDetailsPath,
        name: 'sitter-details',
        builder: (context, state) {
          final sitterName =
              state.uri.queryParameters['sitterName'] ?? 'Sitter';
          return MainPage(child: SitterDetailsScreen(sitterName: sitterName));
        },
      ),
      GoRoute(
        path: childrenPath,
        name: 'children',
        builder: (context, state) => MainPage(child: ChildrenScreen()),
      ),
    ],
  );
}
