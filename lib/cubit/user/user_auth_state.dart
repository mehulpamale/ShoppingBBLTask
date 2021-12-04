part of 'user_auth_cubit.dart';

@immutable
abstract class UserAuthState {}

class UserAuthInitial extends UserAuthState {}

class UserAuthUserNotLoggedIn extends UserAuthState {
  UserAutthUserNotLoggedIn() {
    debugPrint('UserAutthhUserNotLoggedIn');
  }
}

class UserAuthUserLoggingIn extends UserAuthState {
  UserAutthUserLoggingIn() {
    debugPrint('UserAutthhUserLoggingIn');
  }
}

class UserAuthUserLoggedIn extends UserAuthState {
  final String phoneNumber;

  UserAuthUserLoggedIn(this.phoneNumber);
  UserAutthUserLoggedIn() {
    debugPrint('UserAutthhUserLoggedIn');
  }
}
