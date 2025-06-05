
import 'package:expense_app/data/models/expense_model.dart';

class FilteredExpenseModel{

  String title;
  num bal;
  List<ExpenseModel> allExpense;

  FilteredExpenseModel({required this.title,required this.bal,required this.allExpense});

}