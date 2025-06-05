
import 'package:expense_app/ui/pages/add_expense.dart';
import 'package:expense_app/ui/pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui/pages/bloc/expense_event.dart';
import 'package:expense_app/ui/pages/first_page.dart';
import 'package:expense_app/ui/pages/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(GetInitialExpenseEvent());
  }

  String selectedFilterType = "Date";

  List<String> filterType = ["Date","Month","Year","Category"];

  List<Widget> navPages = [
    HomeBody(),
    FirstPage(),
    AddExpense(),
  ];

  int selectedNavigation = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(
            'assets/images/splash_image-logo.png',
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: 30, color: Colors.black),
          ),
        ],
        title: Text(
          "Expense",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: navPages[selectedNavigation],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home_filled), label: "HOME"),
          NavigationDestination(icon: Icon(Icons.graphic_eq), label: "GRAPH"),
          NavigationDestination(icon: Icon(Icons.add), label: "EXPENSE"),
          NavigationDestination(icon: Icon(Icons.notifications), label: "ALERT"),
          NavigationDestination(icon: Icon(Icons.person), label: "PERSON"),
        ],
        selectedIndex: selectedNavigation,
        backgroundColor: Color(0XFFFEF7FF),
        onDestinationSelected: (index){
          selectedNavigation = index;
          setState(() {

          });
        },
      ),
    );
  }
}

