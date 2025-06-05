
import 'package:expense_app/data/models/expense_model.dart';

abstract class ExpenseEvent{}

class AddExpenseEvent extends ExpenseEvent{

  ExpenseModel mExpense;
  int filterValue;
  AddExpenseEvent({required this.mExpense,this.filterValue =1});
}

class GetInitialExpenseEvent extends ExpenseEvent{
  int filterValue;
  GetInitialExpenseEvent({this.filterValue = 1});
}
