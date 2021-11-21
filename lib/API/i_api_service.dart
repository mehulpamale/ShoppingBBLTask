import 'package:shopping_bbl_task/models/product.dart';

abstract class IAPI {
  Future<List<Product>> getProducts();
}
