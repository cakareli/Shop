import 'package:flutter/material.dart';

import '../widgets/appbar_widgets.dart';

class SubcategoryProducts extends StatelessWidget {
  final String mainCategoryName;
  final String subcategoryName;
  const SubcategoryProducts(
      {required this.mainCategoryName, required this.subcategoryName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: subcategoryName),
        elevation: 0,
      ),
      body: Text(mainCategoryName),
    );
  }
}
