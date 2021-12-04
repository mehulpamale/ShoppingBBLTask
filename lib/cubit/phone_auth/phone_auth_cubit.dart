import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:shopping_bbl_task/API/phone_auth_api.dart';
import 'package:shopping_bbl_task/API/user_api.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final _service = PhoneAuthAPI();
  final _userService = UserAPI();

  PhoneAuthCubit() : super(PhoneAuthUserNotLoggedIn());

  Future loginWithOTP(String number) async {
    _service.verifyPhoneNumber(
      number,
      (PhoneAuthCredential phoneAuthCred) async {
        emit(PhoneAuthVerified(phoneAuthCred));
        emit(PhoneAuthUserLoggingIn());
        await _userService.loginWithCredential(phoneAuthCred);
        emit(PhoneAuthUserLoggedIn());
      },
      (failure) => emit(PhoneAuthFailed(failure)),
      (verificationID, resendToken) =>
          emit(PhoneAuthCodeSentByServer(verificationID, resendToken)),
      (verificationID) {},
    );
  }

  Future loginWithCred(dynamic cred) async {
    UserCredential userCredential = await _userService.loginWithCredential
      (cred);
    emit(PhoneAuthUserLoggedIn());
  }

  // Future addUserToDB(UserCredential userCredential){
  //
  // }

  Future sendReceivedOTPForVerification(
      String otp, String verificationID, int? resendToken) async {
    final phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otp);
    emit(PhoneAuthVerified(phoneAuthCredential));
    loginWithCred(phoneAuthCredential);
  }

  Future logout() async {
    await _service.auth.signOut();
    emit(PhoneAuthUserNotLoggedIn());
  }
}
