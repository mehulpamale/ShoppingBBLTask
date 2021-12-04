import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_bbl_task/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:shopping_bbl_task/cubit/user/user_auth_cubit.dart';
import 'package:shopping_bbl_task/pages/home_screen.dart';
import 'package:shopping_bbl_task/pages/login_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    debugPrint('_WrapperState.build');
    BlocProvider.of<UserAuthCubit>(context).tryLogin();
    return BlocBuilder<UserAuthCubit, UserAuthState>(
      builder: (c, s) {
        if (s is UserAuthUserLoggedIn) {
          return const HomeScreen();
        }
        return BlocBuilder<PhoneAuthCubit, PhoneAuthState>(builder: (c, s) {
          if (s is PhoneAuthUserLoggedIn) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        });
      },
    );
  }
}
