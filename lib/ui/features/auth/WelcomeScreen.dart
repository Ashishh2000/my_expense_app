// ignore: file_names
import 'package:expense_app/data/exp_db_helper.dart';
import 'package:expense_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 250, 252),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              child: Image.asset('assets/images/homeScreenImage.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hello',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Text(
              'Welcome To Little Drop, where\nyou manage your daily tasks',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 49, 48, 48),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: const Size(400, 50),
              ),
              onPressed: () async {
                // LOGIN VIA SHARED PREFS
                // var prefs = await SharedPreferences.getInstance();
                // prefs.setInt(DBHelper.PREFS_USER_ID, 1);

                Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE_ROUTE);
              },
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.deepPurple),
                minimumSize: const Size(400, 50),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.SIGNUP_PAGE_ROUTE);
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Sign up using',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset('assets/images/facebookicon.png'),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset('assets/images/googleicon.png'),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset('assets/images/linkdinicon.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
