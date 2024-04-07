import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/models/products_response.dart';
import 'package:interview_task/utils/urls.dart';
import 'package:logger/logger.dart';
import 'dart:math';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final Map<int, Product> _allProducts = {};

  ProductsBloc() : super(ProductsInitState()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<UpdateProductEvent>(_onUpdateProduct);
    add(FetchProductsEvent());
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    if (_allProducts.containsKey(event.id)) {
      final product = _allProducts[event.id]!;
      _allProducts[event.id] = product.copyWith(amount: event.amount);
      emit(ProductsLoadedState(_allProducts.values.toList()));
    }
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      if (_allProducts.isEmpty) emit(ProductsLoadingState());

      var random = Random().nextInt(90);

      final response = await http.get(Uri.parse(productsUrl.replaceAll('%', random.toString())));

      if (response.statusCode != 200) {
        Logger().i('Error: ${response.statusCode}');
        emit(ProductsErrorState('Error: ${response.statusCode}'));
        return;
      }

      final responseData = ProductsResponse.fromJson(json.decode(response.body));

      for (var product in responseData.products) {
        if (_allProducts.containsKey(product.id)) {
          _allProducts[product.id] =
              product.copyWith(refreshed: _allProducts[product.id]!.refreshed + 1);
        } else {
          _allProducts[product.id] = product;
        }
      }

      emit(ProductsLoadedState(_allProducts.values.toList()));
    } catch (e) {
      Logger().e('Error: $e');
      emit(ProductsErrorState('Error: $e'));
    }
  }
}

/// EVENTS

abstract class ProductsEvent {}

class FetchProductsEvent extends ProductsEvent {}

class UpdateProductEvent extends ProductsEvent {
  final int id;
  final int amount;

  UpdateProductEvent({required this.id, this.amount = 0});
}

/// STATES

abstract class ProductsState {}

class ProductsInitState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final List<Product> products;

  ProductsLoadedState(this.products);
}

class ProductsErrorState extends ProductsState {
  final String message;

  ProductsErrorState(this.message);
}
