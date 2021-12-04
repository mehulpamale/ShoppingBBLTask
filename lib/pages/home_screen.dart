import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_bbl_task/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:shopping_bbl_task/cubit/product_list/product_list_cubit.dart';
import 'package:shopping_bbl_task/pages/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductListCubit>(context).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
        actions: [
          IconButton(
              onPressed: () => null, icon: const Icon(Icons.add_shopping_cart))
        ],
      ),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        builder: (ctx, state) {
          if (state is ProductListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductListLoaded) {
            return productListWid(state);
          } else if (state is ProductListFailure) {
            return Center(child: Text('failure: ${state.failure}'));
          } else if (state is PhoneAuthUserNotLoggedIn) {
            return const LoginScreen();
          }
          return const Center(
            child: Text('failure'),
          );
        },
      ),
    );
  }
}

Widget productListWid(ProductListLoaded productListLoaded) {
  return ListView.builder(
      itemCount: productListLoaded.productList.length,
      itemBuilder: (c, i) {
        final product = productListLoaded.productList[i];
        return ListTile(
            leading: Image.network(product.image),
            title: Text(product.name),
            subtitle: Text(
                '\u{2009}${product.rate} | ${product.quantity} available'));
      });
}
