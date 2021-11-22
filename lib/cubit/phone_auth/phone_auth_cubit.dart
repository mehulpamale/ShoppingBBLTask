import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_bbl_task/API/auth_api.dart';
import 'package:shopping_bbl_task/consts/constants.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final _service = AuthAPI();

  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future tryLogin() async {
    if (_service.auth.currentUser?.uid != null) {
      emit(PhoneAuthUserLoggedIn());
    } else {
      emit(PhoneAuthUserNotLoggedIn());
    }
    // var sp = await SharedPreferences.getInstance();
    // var storedCredentials = sp.get(credentials_string);
    // if (storedCredentials == null || storedCredentials.toString().isEmpty) {
    //   emit(PhoneAuthUserNotLoggedIn());
    // }
    // loginWithCred(storedCredentials);
  }

  Future loginWithOTP(String number) async {
    var sp = await SharedPreferences.getInstance();
    _service.verifyPhoneNumber(
      number,
      (PhoneAuthCredential phoneAuthCred) async {
        emit(PhoneAuthVerified(phoneAuthCred));
        sp.setString(credentials_string, phoneAuthCred.toString());
        emit(PhoneAuthUserLoggingIn());
        await _service.loginWithCredential(phoneAuthCred);
        emit(PhoneAuthUserLoggedIn());
      },
      (failure) => PhoneAuthFailed(failure),
      (verificationID, resendToken) =>
          emit(PhoneAuthCodeSentByServer(verificationID, resendToken)),
      (verificationID) {},
    );
  }

  Future loginWithCred(dynamic cred) async {
    await _service.loginWithCredential(cred);
    emit(PhoneAuthUserLoggedIn());
  }

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
