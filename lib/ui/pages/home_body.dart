import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_constants.dart';
import 'bloc/expense_bloc.dart';
import 'bloc/expense_event.dart';
import 'bloc/expense_state.dart';

class HomeBody extends StatefulWidget {
   const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String selectedFilterType = "Date";

  List<String> filterType = ["Date","Month","Year","Category"];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if(state is LoadingExpenseState){
          return Center(child: CircularProgressIndicator(),);
        }

        if(state is ErrorExpenseState){
          return Center(child: Text(state.errorMessage),);
        }

        if(state is LoadedExpenseState){
          print("Length of Expenses : ${state.mExpenses.length}");

          var allData = state.mExpenses;

          return Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 68,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0XFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 14),
                      Icon(Icons.person, size: 30),
                      SizedBox(width: 14),
                      Column(
                        children: [
                          SizedBox(height: 5),
                          Text(
                            "Morning",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "Ashish",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: DropdownMenu(
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,),
                            inputDecorationTheme: InputDecorationTheme(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 12,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            initialSelection: selectedFilterType,
                            onSelected: (value) {
                              setState(() {
                                selectedFilterType = value!;
                                int filterValue = 1;
                                if(selectedFilterType == "Date"){
                                  filterValue = 1;
                                }else if(selectedFilterType == "Month"){
                                  filterValue = 2;
                                }else if(selectedFilterType == "Year"){
                                  filterValue = 3;
                                }else{
                                  filterValue = 4;
                                }
                                context.read<ExpenseBloc>().add(GetInitialExpenseEvent(filterValue: filterValue));
                              });
                            },
                            dropdownMenuEntries:
                            filterType
                                .map((e) => DropdownMenuEntry(value: e, label: e))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Total Expense
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0XFF6574D3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Expense total",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "\$3,734",
                              style: TextStyle(
                                fontSize: 37,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFFD06160),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "+\$240",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "than last month",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Image.asset('assets/images/expense_app_images copy 2.tiff'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Expense List
                const Text(
                  'Expense List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(itemBuilder: (_,index){
                    return Container(
                      margin: EdgeInsets.only(bottom: 11),
                      padding: EdgeInsets.all(11),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(allData[index].title,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                              Text(allData[index].bal.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Divider(),
                          ListView.builder(shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: allData[index].allExpense.length,
                            itemBuilder: (_,childIndex){
                              return _buildExpenseItem(
                                  AppConstants.mCategory.firstWhere((element){
                                    return element["categoryId"] == allData[index].allExpense[childIndex].expCatId;
                                  })["categoryImage"],
                                  allData[index].allExpense[childIndex].expTitle,
                                  allData[index].allExpense[childIndex].expDesc,
                                  allData[index].allExpense[childIndex].expAmt.toString()
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },itemCount: allData.length,),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildExpenseItem(String imgPath,  String title, String desc, String amount) {
    return ListTile(
      leading: Container(
        width: 45,
        height: 45,
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade100,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Center(child: Image.asset(imgPath),),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(desc),
      trailing: Text(
        amount,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Color(0XFFE88DBE),
        ),
      ),
    );
  }
}
