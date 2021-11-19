import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListInitial());
}
