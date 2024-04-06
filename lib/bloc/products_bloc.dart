import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/models/products_response.dart';
import 'package:interview_task/utils/urls.dart';
import 'package:logger/logger.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitState()) {
    on<FetchProductsEvent>(_onFetchProducts);
    add(FetchProductsEvent());
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      emit(ProductsLoadingState());
      final response = await http.get(Uri.parse(productsUrl));

      if (response.statusCode != 200) {
        Logger().i('Error: ${response.statusCode}');
        emit(ProductsErrorState('Error: ${response.statusCode}'));
        return;
      }

      final responseData = json.decode(response.body);
      final products = ProductsResponse.fromJson(responseData);

      emit(ProductsLoadedState(products));
    } catch (e) {
      Logger().e('Error: $e');
      emit(ProductsErrorState('Error: $e'));
    }
  }
}

/// EVENTS

abstract class ProductsEvent {}

class FetchProductsEvent extends ProductsEvent {}

/// STATES

abstract class ProductsState {}

class ProductsInitState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final ProductsResponse products;

  ProductsLoadedState(this.products);
}

class ProductsErrorState extends ProductsState {
  final String message;

  ProductsErrorState(this.message);
}
