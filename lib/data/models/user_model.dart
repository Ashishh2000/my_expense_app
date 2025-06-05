import 'package:expense_app/data/exp_db_helper.dart';

class UserModel {
  String? userId;
  String userName;
  String userEmail;
  String mobileNumber;
  String userPassword;

  UserModel({
    this.userId,
    required this.userName,
    required this.userEmail,
    required this.mobileNumber,
    required this.userPassword,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map[DBHelper.COLUMN_USER_ID],
      userName: map[DBHelper.COLUMN_USER_NAME],
      userEmail: map[DBHelper.COLUMN_USER_EMAIL],
      mobileNumber: map[DBHelper.COLUMN_USER_MOB_NO],
      userPassword: map[DBHelper.COLUMN_USER_PASS],
    );
  }

  Map<String, dynamic> toMap() => {
    DBHelper.COLUMN_USER_NAME: userName,
    DBHelper.COLUMN_USER_EMAIL: userEmail,
    DBHelper.COLUMN_USER_MOB_NO: mobileNumber,
    DBHelper.COLUMN_USER_PASS: userPassword,
  };
}
