import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_list_count_state.dart';

class CartListCountCubit extends Cubit<CartListCountState> {
  CartListCountCubit() : super(CartListCountInitial());
}
