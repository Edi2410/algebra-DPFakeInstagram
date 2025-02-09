import 'package:dp_project/feature/logging/presentation/screen/logs_screen.dart';
import 'package:dp_project/feature/photos/presentation/screen/add_new_photo_screen.dart';
import 'package:dp_project/feature/photos/presentation/screen/search_photo_screen.dart';
import 'package:dp_project/feature/profile/presentation/screen/change_package_screen.dart';
import 'package:flutter/material.dart';
import 'package:dp_project/feature/auth/presentation/screen/confirm_email_screen.dart';
import 'package:dp_project/feature/auth/presentation/screen/reset_password_screen.dart';
import 'package:dp_project/feature/auth/presentation/screen/sign_in_screen.dart';
import 'package:dp_project/feature/auth/presentation/screen/sign_up_screen.dart';
import 'package:dp_project/feature/common/presentation/screen/splash_screen.dart';
import 'package:dp_project/feature/common/presentation/screen/home_page_screen.dart';

class RouteGenerator {
  static const splashScreen = '/';
  static const signInScreen = '/signIn';
  static const signUpScreen = '/signUp';
  static const resetPasswordScreen = '/resetPassword';
  static const verifyEmailScreen = '/verifyEmail';
  static const homePageScreen = '/homePage';
  static const changePackageScreen = '/changePackage';
  static const addNewPhotoScreen = '/addNewImage';
  static const logsScreen = '/logs';
  static const searchPhotoScreen = '/searchPhoto';

  RouteGenerator._();

  static Route<dynamic> generateRoute(final RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());
      case signInScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SignInScreen());
      case signUpScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SignUpScreen());
      case resetPasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ResetPasswordScreen());
      case homePageScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomePageScreen());
      case verifyEmailScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const VerifyEmailScreen(),
        );
      case changePackageScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ChangePackageScreen(),
        );
      case addNewPhotoScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AddNewPhotoScreen(),
        );
      case logsScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LogsScreen(),
        );
      case searchPhotoScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SearchPhotoScreen(),
        );

      default:
        throw Exception('Route not found...');
    }
  }
}
