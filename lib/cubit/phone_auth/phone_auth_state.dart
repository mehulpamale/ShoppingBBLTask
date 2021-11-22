part of 'phone_auth_cubit.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {
  PhoneAuthInitial() {
    print('PhoneAuthInitial');
  }
}

class PhoneAuthRequestingOTP extends PhoneAuthState {
  PhoneAuthRequestingOTP() {
    print('PhoneAuthRequestingOTP');
  }
}

class PhoneAuthCodeSentByServer extends PhoneAuthState {
  final String verificationID;
  final int? resendToken;

  PhoneAuthCodeSentByServer(this.verificationID, this.resendToken) {
    print('PhoneAuthCodeSentByServer');
  }
}

class PhoneAuthOTPSentForVerification extends PhoneAuthState {
  PhoneAuthOTPSentForVerification() {
    print('PhoneAuthOTPSentForVerification');
  }
}

class PhoneAuthUserNotLoggedIn extends PhoneAuthState {
  PhoneAuthUserNotLoggedIn() {
    print('PhoneAuthUserNotLoggedIn');
  }
}

class PhoneAuthUserLoggingIn extends PhoneAuthState {
  PhoneAuthUserLoggingIn() {
    print('PhoneAuthUserLoggingIn');
  }
}

class PhoneAuthUserLoggedIn extends PhoneAuthState {
  PhoneAuthUserLoggedIn() {
    print('PhoneAuthUserLoggedIn');
  }
}

class PhoneAuthVerified extends PhoneAuthState {
  final PhoneAuthCredential _phoneAuthCredential;

  PhoneAuthVerified(this._phoneAuthCredential) {
    print('PhoneAuthVerified');
  }
}

class PhoneAuthFailed extends PhoneAuthState {
  final dynamic failure;

  PhoneAuthFailed(this.failure) {
    print('PhoneAuthFailed');
  }
}
