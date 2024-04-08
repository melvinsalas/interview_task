import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/bloc/products_bloc.dart';
import 'package:interview_task/models/products_response.dart';
import 'package:interview_task/utils/text_field_custom.dart';

class ProductDetailsWidget extends StatefulWidget {
  final Product product;

  const ProductDetailsWidget({super.key, required this.product});

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  var amount = 0;

  @override
  void initState() {
    super.initState();

    /// Set initial amount value from product model
    amount = widget.product.amount;
  }

  void _updateAmount(int value) {
    /// Prevent negative amount
    if (amount + value < 0) return;

    /// Update amount
    setState(() {
      amount += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(widget.product.thumbnail, width: 100, height: 100, fit: BoxFit.cover),
              const SizedBox(width: 8),
              Expanded(child: Text('€${widget.product.description}')),
            ],
          ),
          const SizedBox(height: 16),
          TextFieldCustom(
            hintText: widget.product.price.toString(),
            enabled: false,
            prefixIcon: const Icon(Icons.euro),
          ),
          const SizedBox(height: 16),
          TextFieldCustom(
            hintText: widget.product.brand,
            enabled: false,
            prefixIcon: const Icon(Icons.sell),
          ),
          const SizedBox(height: 16),
          TextFieldCustom(
            hintText: widget.product.rating.toString(),
            enabled: false,
            prefixIcon: const Icon(Icons.star),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () => _updateAmount(-1),
                child: const Icon(Icons.remove),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('$amount', style: const TextStyle(fontSize: 20)),
              ),
              TextButton(
                onPressed: () => _updateAmount(1),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<ProductsBloc>().add(UpdateProductEvent(id: widget.product.id));
            Navigator.of(context).pop();
          },
          child: const Text('Delete'),
        ),
        TextButton(
          onPressed: () {
            context
                .read<ProductsBloc>()
                .add(UpdateProductEvent(id: widget.product.id, amount: amount));
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
