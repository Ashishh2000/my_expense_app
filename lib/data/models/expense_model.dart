import 'package:expense_app/data/exp_db_helper.dart';

class ExpenseModel {
  int? expId;
  int? userId;
  String expTitle;
  String expDesc;
  double expAmt;
  double expBal;
  int expCatId;
  int expType;
  String expCreatedAt;

  ExpenseModel({
    this.expId,
    this.userId,
    required this.expTitle,
    required this.expDesc,
    required this.expAmt,
    required this.expBal,
    required this.expCatId,
    required this.expType,
    required this.expCreatedAt,
  });

  Map<String, dynamic> toMap() => {
    DBHelper.COLUMN_USER_ID: userId,
    DBHelper.COLUMN_EXP_TITLE: expTitle,
    DBHelper.COLUMN_EXP_DESC: expDesc,
    DBHelper.COLUMN_EXP_AMT: expAmt,
    DBHelper.COLUMN_EXP_BAL: expBal,
    DBHelper.COLUMN_EXP_CAT_ID: expCatId,
    DBHelper.COLUMN_EXP_TYPE: expType,
    DBHelper.COLUMN_EXP_CREATED_AT: expCreatedAt,
  };

  factory ExpenseModel.fromMap(Map<String, dynamic> map) => ExpenseModel(
    expId: map[DBHelper.COLUMN_EXP_ID],
    userId: map[DBHelper.COLUMN_USER_ID],
    expTitle: map[DBHelper.COLUMN_EXP_TITLE],
    expDesc: map[DBHelper.COLUMN_EXP_DESC],
    expAmt: map[DBHelper.COLUMN_EXP_AMT],
    expBal: map[DBHelper.COLUMN_EXP_BAL],
    expCatId: map[DBHelper.COLUMN_EXP_CAT_ID],
    expType: map[DBHelper.COLUMN_EXP_TYPE],
    expCreatedAt: map[DBHelper.COLUMN_EXP_CREATED_AT],
  );
}
