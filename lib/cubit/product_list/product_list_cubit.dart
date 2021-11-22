import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_bbl_task/API/product_api.dart';
import 'package:shopping_bbl_task/models/product_model.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final _service = ProductAPI();

  ProductListCubit() : super(ProductListInitial());

  Future getProducts() async {
    emit(ProductListLoading());
    try {
      final products = await _service.getProducts();
      emit(ProductListLoaded(products));
    } on Exception catch (e) {
      emit(ProductListFailure(e.toString()));
    }
  }
}
