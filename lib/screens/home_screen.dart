import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/bloc/products_bloc.dart';
import 'package:interview_task/screens/sale_screen.dart';
import 'package:interview_task/widgets/products_widget.dart';
import 'package:interview_task/widgets/profile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// The state for the [HomeScreen] widget.
/// This class is stateful because it needs to keep track of the selected index for the bottom
/// navigation bar.
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  String get _title {
    if (_selectedIndex == 0) return 'Products';
    if (_selectedIndex == 1) return 'Profile';
    return '';
  }

  void _onTap(int value) {
    if (value == 2) {
      /// When the user taps on the sale icon, navigate to the sale screen using imperative
      /// navigation instead of changing the selected index.
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SaleScreen()));
    } else {
      setState(() => _selectedIndex = value);
    }
  }

  List<Widget>? get _actions {
    final actions = <Widget>[];
    if (_selectedIndex == 0) {
      /// This action get new products from the server, it was used for testing purposes.
      actions.add(IconButton(
          icon: const Icon(Icons.science),
          onPressed: () {
            context.read<ProductsBloc>().add(FetchProductsEvent());
          }));
    }
    return actions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title), actions: _actions),
      body: _selectedIndex == 0 ? const ProductsWidget() : const ProfileWidget(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0 ? Icons.sell : Icons.sell_outlined),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1 ? Icons.person : Icons.person_outline),
            label: 'Profile',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_outlined),
            label: 'Sale',
          ),
        ],
        onTap: _onTap,
      ),
    );
  }
}
