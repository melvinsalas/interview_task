import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/bloc/auth_bloc.dart';
import 'package:interview_task/models/products_response.dart';
import 'package:interview_task/utils/token_storage.dart';
import 'package:interview_task/utils/urls.dart';
import 'package:logger/logger.dart';
import 'dart:math';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final Map<int, Product> _allProducts = {};

  ProductsBloc() : super(ProductsInitState()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<CheckoutProductsEvent>(_onCheckoutProducts);
    on<ResetProductsEvent>(_onResetProducts);
    // add(FetchProductsEvent());
  }

  void _onResetProducts(
    ResetProductsEvent event,
    Emitter<ProductsState> emit,
  ) {
    _allProducts.clear();

    emit(ProductsInitState());
  }

  void _onCheckoutProducts(
    CheckoutProductsEvent event,
    Emitter<ProductsState> emit,
  ) {
    final products = _allProducts.values.where((element) => element.amount > 0).toList();

    for (var product in products) {
      _allProducts[product.id] = product.copyWith(amount: 0);
    }

    emit(ProductsLoadedState(_allProducts.values.toList()));
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

      final response = await http.get(
        Uri.parse(productsUrl.replaceAll('%', random.toString())),
        headers: {
          'Authorization': 'Bearer ${TokenStorage.getToken()}',
        },
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 403 || response.statusCode == 500) {
          Logger().i('Unauthorized');
          GetIt.I.get<AuthBloc>().add(LogoutEvent());
          return;
        }
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

class CheckoutProductsEvent extends ProductsEvent {}

class ResetProductsEvent extends ProductsEvent {}

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
