import 'dart:async';

import 'package:expense_app/data/exp_db_helper.dart';
import 'package:expense_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () async {
      var prefs = await SharedPreferences.getInstance();
      var id = prefs.getInt(DBHelper.PREFS_USER_ID) ?? 0;

      if (id != 0) {
        Navigator.pushReplacementNamed(context, AppRoutes.DASHBOARD_PAGE_ROUTE);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.WELCOME_PAGE_ROUTE);
      }
      // Navigator.pushReplacementNamed(context, AppRoutes.WELCOME_PAGE_ROUTE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade50,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/splash_image-logo.png',
                  fit: BoxFit.cover,
                  height: 450,
                  width: 450,
                ),
              ),
            ),
            SizedBox(height: 21),
            Text(
              "Expense Tracker",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
