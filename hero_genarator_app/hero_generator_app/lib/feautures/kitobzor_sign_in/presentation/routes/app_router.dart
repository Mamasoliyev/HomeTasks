import 'package:go_router/go_router.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/view/pages/book_page.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/view/pages/favourite_page.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/view/pages/navigation_page.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/view/pages/profile_page.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/view/pages/subcategory_page.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/presentation/pages/onboarding_page.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/presentation/pages/otp_page.dart';
import '../pages/signup_page.dart';
import '../pages/splash_page.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/view/pages/home_page.dart';

final router = GoRouter(
  initialLocation: '/navigation',

  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
    GoRoute(
      path: '/otp',
      builder: (context, state) => OtpPage(phoneNumber: state.extra as String),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    GoRoute(path: '/navigation', builder: (context, state) => NavigationPage()),
    //SubCategoryScreen
    GoRoute(
      path: '/subcategory',
      builder: (context, state) {
        final categoryId = int.parse(state.pathParameters['id'] ?? '0');
        final categoryName = state.pathParameters['name'] ?? '';
        return SubCategoryPage(
          categoryId: categoryId,
          categoryName: categoryName,
        );
      },
    ),
    GoRoute(
      path: '/books',
      builder: (context, state) => BookPage(),
    ),
    // favorite page
    GoRoute(path: '/favorite', builder: (context, state) => const FavoritePage()),
    // profile page
    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
  ],
);
