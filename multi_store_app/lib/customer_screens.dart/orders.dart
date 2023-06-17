import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const AppBarTitle(title: 'Customer Orders'),
      ),
    );
  }
}
