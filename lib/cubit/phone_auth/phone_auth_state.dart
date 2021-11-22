part of 'phone_auth_cubit.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthRequestingOTP extends PhoneAuthState {}

class PhoneAuthCodeSentByServer extends PhoneAuthState {
  final String verificationID;
  final int? resendToken;

  PhoneAuthCodeSentByServer(this.verificationID, this.resendToken);
}

class PhoneAuthOTPSentForVerification extends PhoneAuthState {}

class PhoneAuthUserNotLoggedIn extends PhoneAuthState {}

class PhoneAuthUserLoggingIn extends PhoneAuthState {}

class PhoneAuthUserLoggedIn extends PhoneAuthState {

  PhoneAuthUserLoggedIn();
}

class PhoneAuthVerified extends PhoneAuthState {
  final PhoneAuthCredential _phoneAuthCredential;

  PhoneAuthVerified(this._phoneAuthCredential);
}

class PhoneAuthFailed extends PhoneAuthState {
  final String failure;

  PhoneAuthFailed(this.failure);
}
