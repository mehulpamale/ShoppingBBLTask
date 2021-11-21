import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'number_auth_state.dart';

class NumberAuthCubit extends Cubit<NumberAuthState> {
  NumberAuthCubit() : super(NumberAuthInitial());
}
