part of 'phone_auth_cubit.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {
  PhoneAuthInitial() {
    debugPrint('PhoneAuthInitial');
  }
}

class PhoneAuthRequestingOTP extends PhoneAuthState {
  PhoneAuthRequestingOTP() {
    debugPrint('PhoneAuthRequestingOTP');
  }
}

class PhoneAuthCodeSentByServer extends PhoneAuthState {
  final String verificationID;
  final int? resendToken;

  PhoneAuthCodeSentByServer(this.verificationID, this.resendToken) {
    debugPrint('PhoneAuthCodeSentByServer');
  }
}

class PhoneAuthOTPSentForVerification extends PhoneAuthState {
  PhoneAuthOTPSentForVerification() {
    debugPrint('PhoneAuthOTPSentForVerification');
  }
}

class PhoneAuthUserNotLoggedIn extends PhoneAuthState {
  PhoneAuthUserNotLoggedIn() {
    debugPrint('PhoneAuthUserNotLoggedIn');
  }
}

class PhoneAuthUserLoggingIn extends PhoneAuthState {
  PhoneAuthUserLoggingIn() {
    debugPrint('PhoneAuthUserLoggingIn');
  }
}

class PhoneAuthUserLoggedIn extends PhoneAuthState {
  PhoneAuthUserLoggedIn() {
    debugPrint('PhoneAuthUserLoggedIn');
  }
}

class PhoneAuthVerified extends PhoneAuthState {
  final PhoneAuthCredential _phoneAuthCredential;

  PhoneAuthVerified(this._phoneAuthCredential) {
    debugPrint('PhoneAuthVerified');
  }
}

class PhoneAuthFailed extends PhoneAuthState {
  final dynamic failure;

  PhoneAuthFailed(this.failure) {
    debugPrint('PhoneAuthFailed: $failure');
  }
}
