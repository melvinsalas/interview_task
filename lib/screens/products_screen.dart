import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/bloc/products_bloc.dart';
import 'package:interview_task/widgets/products_widget.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is ProductsErrorState) {
          /// Show a snackbar with the error message.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is ProductsInitState) {
          /// Fetch the products when the screen is initialized.
          context.read<ProductsBloc>().add(FetchProductsEvent());
        }
      },
      child: const ProductsWidget(),
    );
  }
}
