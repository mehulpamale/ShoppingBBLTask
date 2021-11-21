part of 'product_list_cubit.dart';

@immutable
abstract class ProductListState {}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<Product> productList;

  ProductListLoaded(this.productList);
}

class ProductListFailure extends ProductListState {
  final String failure;

  ProductListFailure(this.failure);
}
