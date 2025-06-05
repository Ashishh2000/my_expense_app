import 'package:expense_app/data/exp_db_helper.dart';
import 'package:expense_app/routes/app_routes.dart';
import 'package:expense_app/ui/features/auth/bloc/user_bloc.dart';
import 'package:expense_app/ui/pages/bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => UserBloc(dbHelper: DBHelper.getInstance())),
      BlocProvider(create: (context) => ExpenseBloc(dbHelper: DBHelper.getInstance()))
    ], child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense App",
      initialRoute: AppRoutes.SPLASH_PAGE_ROUTE,
      routes: AppRoutes.mRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
