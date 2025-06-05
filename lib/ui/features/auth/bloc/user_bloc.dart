import 'package:expense_app/data/exp_db_helper.dart';
import 'package:expense_app/ui/features/auth/bloc/user_event.dart';
import 'package:expense_app/ui/features/auth/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  DBHelper dbHelper;

  UserBloc({required this.dbHelper}) : super(UserInitialState()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(UserLoadingState());

      bool oldUserExists = await dbHelper.checkIfUserAlreadyExists(
        email: event.newUser.userEmail,
      );
      if (!oldUserExists) {
        bool check = await dbHelper.createUser(userModel: event.newUser);
        if (check) {
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMessage: "Something went Wrong"));
        }
      } else {
        emit(UserFailureState(errorMessage: "Email already exists"));
      }
    });

    on<LoginUserEvent>((event, emit) async {
      emit(UserLoadingState());

      bool isUserValid = await dbHelper.authenticateUser(
        email: event.email,
        password: event.password,
      );
      if (isUserValid) {
        emit(UserSuccessState());
      } else {
        emit(UserFailureState(errorMessage: "Invalid email or password"));
      }
    });
  }
}
