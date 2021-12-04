import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:shopping_bbl_task/API/user_api.dart';

part 'user_auth_state.dart';

class UserAuthCubit extends Cubit<UserAuthState> {
  UserAuthCubit() : super(UserAuthInitial());
  final _userAPI = UserAPI();

  Stream<bool> isLoggedIn() {
    return Stream.value(_userAPI.isLoggedIn());
  }

  Future addUser(String phoneNumber) async {
    return _userAPI.addUserToDB(phoneNumber);
  }

  Future tryLogin() async {
    if (_userAPI.isLoggedIn()) {
      emit(UserAuthUserLoggedIn(_userAPI.getPhoneNumber()));
      addUser(_userAPI.getPhoneNumber());
      debugPrint('UserAuthCubit.tryLogin.yes');
    } else {
      emit(UserAuthUserNotLoggedIn());
      debugPrint('UserAuthCubit.tryLogin.not');
    }
    // var sp = await SharedPreferences.getInstance();
    // var storedCredentials = sp.get(credentials_string);
    // if (storedCredentials == null || storedCredentials.toString().isEmpty) {
    //   emit(PhoneAuthUserNotLoggedIn());
    // }
    // loginWithCred(storedCredentials);
  }
}
