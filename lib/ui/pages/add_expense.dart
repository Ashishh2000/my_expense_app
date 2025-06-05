import 'package:expense_app/app_constants.dart';
import 'package:expense_app/data/models/expense_model.dart';
import 'package:expense_app/ui/pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui/pages/bloc/expense_event.dart';
import 'package:expense_app/ui/pages/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/exp_db_helper.dart';

// ignore: must_be_immutable
class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  int selectedCategory = -1;

  String selectedExpenseType = "Debit";

  List<String> mExpenseType = ["Debit", "Credit"];

  DateTime? selectedDate;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DBHelper? dbHelper;

  DateFormat df = DateFormat.yMMMEd();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      appBar: AppBar(
        foregroundColor: Colors.black87,
        title: Text(
          "Add Expense",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.blue.shade50,
      ),
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.blue.shade50,
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    'assets/images/splash_image-logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Add your expense details below:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Title is required";
                      }else{
                        return null;
                      }
                    },
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: "Title",
                      hintText: "Enter a title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Description is required";
                      }else{
                        return null;
                      }
                    },
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: "Enter a description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Amount is required";
                      }else{
                        return null;
                      }
                    },
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      hintText: "Enter an amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            width: double.infinity,
                            height: 400,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 11, bottom: 11),
                              child: GridView.builder(
                                itemCount: AppConstants.mCategory.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                    ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      selectedCategory = index;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          AppConstants
                                              .mCategory[index]["categoryImage"],
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text(
                                          AppConstants
                                              .mCategory[index]["categoryName"],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.transparent,
                    ),
                    child:
                        selectedCategory >= 0
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${AppConstants.mCategory[selectedCategory]["categoryName"]} -",
                                ),
                                Image.asset(
                                  AppConstants
                                      .mCategory[selectedCategory]["categoryImage"],
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            )
                            : Text(
                              "Choose Category",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                              ),
                            ),
                  ),
                  SizedBox(height: 15),
                  ///  Drop Down button
                  //****************************************** */
                  // SizedBox(
                  //   height: 50,
                  //   width: double.infinity,
                  //   child: DropdownMenu(
                  //     width: double.infinity,
                  //     textStyle: TextStyle(fontSize: 18, color: Colors.black87),
                  //     inputDecorationTheme: InputDecorationTheme(
                  //       contentPadding: EdgeInsets.symmetric(
                  //         horizontal: 12,
                  //         vertical: 14,
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: BorderSide(
                  //           width: 1,
                  //           color: Colors.blueGrey,
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: BorderSide(
                  //           width: 1,
                  //           color: Colors.blueGrey,
                  //         ),
                  //       ),
                  //     ),
                  //     initialSelection: selectedExpenseType,
                  //     onSelected: (value) {
                  //       setState(() {
                  //         selectedExpenseType = value!;
                  //       });
                  //     },
                  //     dropdownMenuEntries:
                  //         mExpenseType
                  //             .map((e) => DropdownMenuEntry(value: e, label: e))
                  //             .toList(),
                  //   ),
                  // ),
                  //************************************* */
                  // DropdownButton(
                  //   value: selectedExpenseType,
                  //   items:
                  //       mExpenseType.map((e) {
                  //         return DropdownMenuItem(value: e, child: Text(e));
                  //       }).toList(),
                  //   onChanged: (value) {
                  //     selectedExpenseType = value!;
                  //     setState(() {});
                  //   },
                  // ),
                  //************************************* */
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(
                  //     elevation: 0,
                  //     shape: RoundedRectangleBorder(
                  //       side: BorderSide(width: 1, color: Colors.blueGrey),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     minimumSize: const Size(double.infinity, 50),
                  //     backgroundColor: Colors.transparent,
                  //   ),
                  //   child: Text(
                  //     "Expense Type",
                  //     style: TextStyle(color: Colors.black87, fontSize: 18),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        mExpenseType.map((e) {
                          return RadioMenuButton(
                            value: e,
                            groupValue: selectedExpenseType,
                            onChanged: (value) {
                              selectedExpenseType = value!;
                              setState(() {});
                            },
                            child: Text(e),
                          );
                        }).toList(),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now().subtract(Duration(days: 730)),
                        lastDate: DateTime.now(),
                      );
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.transparent,
                    ),
                    child: Text(
                      df.format((selectedDate ?? DateTime.now())),
                      style: TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 15),
                  BlocListener<ExpenseBloc,ExpenseState>(
                      listener: (context,state){
                       if(state is LoadingExpenseState){
                         isLoading = true;
                         setState(() {

                         });
                       }else if(state is ErrorExpenseState){
                         isLoading = false;
                         setState(() {

                         });

                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));

                       }else if(state is LoadedExpenseState){
                            isLoading = false;
                            Navigator.pop(context);
                       }
                  },child:  ElevatedButton(
                    onPressed: () {
                      /// Validation
                      if(formKey.currentState !.validate()){
                        if(selectedCategory>0){
                          ExpenseModel newExpense = ExpenseModel(
                              expTitle: titleController.text,
                              expDesc: descriptionController.text,
                              expAmt:  double.parse(amountController.text),
                              expBal: 0,
                              expCatId: AppConstants.mCategory[selectedCategory]["categoryId"],
                              expType: selectedExpenseType == "Debit" ? 1 : 2,
                              expCreatedAt: (selectedDate ?? DateTime.now()).millisecondsSinceEpoch.toString());

                          context.read<ExpenseBloc>().add(AddExpenseEvent(mExpense: newExpense));

                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select a Category !!!")));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Color.fromARGB(223, 236, 159, 219),
                    ),
                    child: isLoading ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 11,),
                        Text("Adding Expense...")
                      ],
                    ) : Text(
                      "Add Expense",
                      style: TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                  ),)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
