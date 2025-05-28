import 'package:expense_app/ui/pages/add_expense.dart';
import 'package:expense_app/ui/pages/splash/splash_page.dart';
import 'package:expense_app/ui/features/auth/SignUpScreen.dart';
import 'package:expense_app/ui/features/auth/WelcomeScreen.dart';
import 'package:expense_app/ui/features/auth/login_screen.dart';
import 'package:expense_app/ui/pages/dashboard_screen.dart';
import 'package:expense_app/ui/pages/first_page.dart';
import 'package:expense_app/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const SPLASH_PAGE_ROUTE = '/';
  static const HOME_PAGE_ROUTE = '/home';
  static const DASHBOARD_PAGE_ROUTE = '/dashboard';
  static const FIRST_PAGE_ROUTE = '/first';
  static const WELCOME_PAGE_ROUTE = '/welcome';
  static const LOGIN_PAGE_ROUTE = '/login';
  static const SIGNUP_PAGE_ROUTE = '/signup';
  static const ADD_EXPENSE_PAGE_ROUTE = '/add_expense';

  static Map<String, Widget Function(BuildContext)> mRoutes = {
    SPLASH_PAGE_ROUTE: (context) => SplashPage(),
    HOME_PAGE_ROUTE: (context) => HomePage(),
    FIRST_PAGE_ROUTE: (context) => FirstPage(),
    DASHBOARD_PAGE_ROUTE: (context) => DashboardScreen(),
    WELCOME_PAGE_ROUTE: (context) => WelcomeScreen(),
    LOGIN_PAGE_ROUTE: (context) => LoginScreen(),
    SIGNUP_PAGE_ROUTE: (context) => SignUpScreen(),
    ADD_EXPENSE_PAGE_ROUTE: (context) => AddExpense(),
  };
}
