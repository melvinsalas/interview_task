import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/bloc/products_bloc.dart';
import 'package:interview_task/screens/success_screen.dart';
import 'package:interview_task/utils/elevated_button_custom.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Center(
        child: ElevatedButtonCustom(
          onPressed: () {
            context.read<ProductsBloc>().add(CheckoutProductsEvent());
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const SuccessScreen(),
            ));
          },
          text: 'Pay',
        ),
      ),
    );
  }
}
