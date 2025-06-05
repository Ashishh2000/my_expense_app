
import 'package:expense_app/app_constants.dart';
import 'package:expense_app/data/exp_db_helper.dart';
import 'package:expense_app/data/models/expense_model.dart';
import 'package:expense_app/data/models/filtered_expense_model.dart';
import 'package:expense_app/ui/pages/bloc/expense_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'expense_event.dart';

class ExpenseBloc extends Bloc<ExpenseEvent,ExpenseState>{

  DBHelper dbHelper;
  ExpenseBloc({required this.dbHelper}) : super(InitialExpenseState()){
    on<AddExpenseEvent>((event,emit) async{
      emit(LoadingExpenseState());

     bool check = await dbHelper.addExpense(expense: event.mExpense,);

     if(check){
       var allExpense = await dbHelper.fetchAllExpense();
        emit(LoadedExpenseState(mExpenses: filterExpenses(mExpense: allExpense , filterType: event.filterValue)));
     }else{
       emit(ErrorExpenseState(errorMessage: "Expense not Added !!"));
     }

    });
    
    on<GetInitialExpenseEvent>((event,emit) async{
      var allExpense = await dbHelper.fetchAllExpense();
      emit(LoadedExpenseState(mExpenses: filterExpenses(mExpense: allExpense, filterType: event.filterValue)));
    });
  }

}

// Filtered Expenses

   List<FilteredExpenseModel> filterExpenses({required List<ExpenseModel> mExpense,int filterType = 3}){

    List<FilteredExpenseModel> filterExpense = [];
      // date-wise
     // unique Dates

    if(filterType<4){
      DateFormat df = DateFormat.yMMMEd();
      if(filterType ==1){
        DateFormat.yMMMEd();
      } else if(filterType ==2){
        DateFormat.yMMM();
      } else if(filterType == 3){
        DateFormat.y();
      }

      List<String> uniqueDates = [];

      for(ExpenseModel eachExpense in mExpense){
        // each date
        String eachDate = df.format((DateTime.fromMillisecondsSinceEpoch(int.parse(eachExpense.expCreatedAt))));
        // unique date find-out logic
        if(!uniqueDates.contains(eachDate)){
          uniqueDates.add(eachDate);
        }
      }
      print("UNIQUE DATES : - $uniqueDates");

      for(String eachDate in uniqueDates){
        num bal =0.0;
        List<ExpenseModel> eachDateExp = [];

        for(ExpenseModel eachExp in mExpense){
          String expDate = df.format((DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expCreatedAt))));

          if(eachDate == expDate){
            eachDateExp.add(eachExp);
            if(eachExp.expAmt==1){
              bal -= eachExp.expAmt;
            }else{
              bal += eachExp.expAmt;
            }
          }
        }
        print("eachDate $eachDate , bal $bal , allExpense ${eachDateExp.length}");

        filterExpense.add(FilteredExpenseModel(title: eachDate, bal: bal, allExpense: eachDateExp));

      }
    }else{
      // Category wise
      // unique categories
      for(Map<String,dynamic> eachCategory in AppConstants.mCategory){
        num bal = 0.0;
        List<ExpenseModel> eachCategoryExp = [];

        for(ExpenseModel eachExp in mExpense){
          if(eachExp.expCatId==eachCategory["categoryId"]){
            eachCategoryExp.add(eachExp);
            if(eachExp.expType==1){
              bal -= eachExp.expAmt;
            }else{
              bal += eachExp.expAmt;
            }
          }
        }
         if(eachCategoryExp.isNotEmpty) {
           filterExpense.add(FilteredExpenseModel(
               title: eachCategory["categoryName"],
               bal: bal,
               allExpense: eachCategoryExp));
         }
      }
    }

     return filterExpense;
   }