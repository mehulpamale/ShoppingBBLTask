import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_bbl_task/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:shopping_bbl_task/cubit/user/user_auth_cubit.dart';
import 'package:shopping_bbl_task/pages/home_screen.dart';
import 'package:shopping_bbl_task/widgets/named_circular_progress_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numberTEC = TextEditingController();
  var hintText = '';
  var buttonText = 'Request OTP';
  var infoText = '';
  var counter = 2.00;
  var tfReadOnly = false;
  var buttonClick = () {};

  @override
  void initState() {
    debugPrint('_LoginScreenState.initState');
    BlocProvider.of<UserAuthCubit>(context).tryLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
        builder: (c, s) {
          if (s is PhoneAuthInitial) {
            debugPrint('_LoginScreenState.build');
            return const Center(child: CircularProgressIndicator());
          } else if (s is PhoneAuthUserLoggingIn) {
            return const Center(child: CircularProgressIndicator());
          } else if (s is PhoneAuthUserLoggedIn) {
            BlocProvider.of<UserAuthCubit>(context).tryLogin();
            Navigator.pushReplacement(
                c, MaterialPageRoute(builder: (c) => const HomeScreen()));
          } else if (s is PhoneAuthVerified) {
            return const Center(child: CircularProgressIndicator());
          } else if (s is PhoneAuthFailed) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('failure: ${s.failure}\nplease try again'),
                ElevatedButton(
                    onPressed: () => BlocProvider.of<UserAuthCubit>(context)
                        .emit(UserAuthUserNotLoggedIn()),
                    child: const Text('Retry'))
              ],
            ));
          } else if (s is PhoneAuthUserNotLoggedIn) {
            buttonClick = () {
              BlocProvider.of<PhoneAuthCubit>(context)
                  .loginWithOTP(numberTEC.text);
            };
            return loginScreen();
          } else if (s is PhoneAuthRequestingOTP) {
            return const NamedCircularProgressIndicator('requesting OTP');
          } else if (s is PhoneAuthCodeSentByServer) {
            infoText = 'Please enter the OTP received';
            numberTEC.clear();
            buttonText = 'Verify OTP';
            buttonClick = () {
              BlocProvider.of<PhoneAuthCubit>(context)
                  .sendReceivedOTPForVerification(
                      numberTEC.text, s.verificationID, s.resendToken);
            };
            return loginScreen();
          } else if (s is PhoneAuthOTPSentForVerification) {
            return const NamedCircularProgressIndicator('verifying OTP');
          }
          return (const Center(child: Text('failure')));
        },
      ),
    );
  }

  Widget loginScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Login with OTP',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              readOnly: tfReadOnly,
              controller: numberTEC,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: hintText,
              )),
          const SizedBox(
            height: 10,
          ),
          Text(infoText),
          const SizedBox(height: 5),
          ElevatedButton(
              onPressed: buttonClick
              //     () {
              //   // spTest();
              //   // phoneTest();
              //   // Navigator.push(
              //   //   context, MaterialPageRoute(builder: (c) => const HomeScreen())
              //   // );
              // }
              ,
              child: Text(buttonText))
        ]),
      ),
    );
  }
}
