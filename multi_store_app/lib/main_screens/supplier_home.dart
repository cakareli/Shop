import 'package:flutter/material.dart';
import 'package:multi_store_app/main_screens/dashboard.dart';
import 'package:multi_store_app/main_screens/home.dart';
import 'package:multi_store_app/main_screens/store.dart';
import 'package:multi_store_app/main_screens/upload_product.dart';

import 'category.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({Key? key}) : super(key: key);

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int selectedIndex = 0;
  List<Widget> screensList = [
    const HomeScreen(),
    CategoryScreen(),
    const StoreScreen(),
    DashboardScreen(),
    UploadProductScreen(),
  ];
  _changeIndex(int index) {
    selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screensList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) => _changeIndex(value),
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Category',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Stores',
            icon: Icon(Icons.shop),
          ),
          BottomNavigationBarItem(
            label: 'Dashboard',
            icon: Icon(Icons.dashboard),
          ),
          BottomNavigationBarItem(
            label: 'Upload',
            icon: Icon(Icons.upload),
          ),
        ],
      ),
    );
  }
}
