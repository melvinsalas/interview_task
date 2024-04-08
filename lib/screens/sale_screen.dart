import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/bloc/products_bloc.dart';
import 'package:interview_task/models/products_response.dart';
import 'package:interview_task/screens/checkout_screen.dart';
import 'package:interview_task/utils/elevated_button_custom.dart';
import 'package:interview_task/widgets/product_details_widget.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({super.key});
  void _showProductDialog(BuildContext context, {required Product product}) {
    showDialog(
      context: context,
      builder: (_) => ProductDetailsWidget(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale'),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoadedState) {
            var products = state.products.where((product) => product.amount > 0).toList();
            if (products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_basket_outlined, size: 100, color: Colors.grey.shade300),
                    const Text('No products in cart'),
                  ],
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(product.thumbnail)),
                        title: Text('${product.amount}x ${product.title}',
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        subtitle: Text('€${product.price.toString()}'),
                        onTap: () => _showProductDialog(context, product: product),
                        trailing: Text('€${(product.price * product.amount).toString()}'),
                      );
                    },
                  ),
                ),
                ElevatedButtonCustom(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const CheckoutScreen(),
                      ));
                    },
                    text: 'Checkout'),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
