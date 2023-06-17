import 'package:flutter/material.dart';
import 'package:multi_store_app/categories/accessories_categ.dart';
import 'package:multi_store_app/categories/bags_categ.dart';
import 'package:multi_store_app/categories/beauty_categ.dart';
import 'package:multi_store_app/categories/electronics_categ.dart';
import 'package:multi_store_app/categories/homegarden_categ.dart';
import 'package:multi_store_app/categories/kids_categ.dart';
import 'package:multi_store_app/categories/shoes_categ.dart';
import 'package:multi_store_app/categories/women_categ.dart';
import 'package:multi_store_app/widgets/fake_search.dart';

import '../categories/men_categ.dart';

List<ItesmData> items = [
  ItesmData(label: 'men'),
  ItesmData(label: 'women'),
  ItesmData(label: 'shoes'),
  ItesmData(label: 'bags'),
  ItesmData(label: 'electronics'),
  ItesmData(label: 'accessories'),
  ItesmData(label: 'home & garden'),
  ItesmData(label: 'kids'),
  ItesmData(label: 'beauty'),
];

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    for (var element in items) {
      if (element.isSelected) {
        element.isSelected = false;
      }
    }
    setState(() {
      items[0].isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const FakeSearch(),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: sideNavigator(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: categoryView(),
          ),
        ],
      ),
    );
  }

  Widget sideNavigator() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.2,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(index,
                  duration: const Duration(
                    milliseconds: 100,
                  ),
                  curve: Curves.bounceInOut);
            },
            child: Container(
              color:
                  items[index].isSelected ? Colors.white : Colors.grey.shade300,
              height: 100,
              child: Center(
                child: Text(
                  items[index].label,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget categoryView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.8,
      child: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          for (var element in items) {
            if (element.isSelected) {
              element.isSelected = false;
            }
          }
          setState(() {
            items[value].isSelected = true;
          });
        },
        scrollDirection: Axis.vertical,
        children: const [
          MenCategory(),
          WomenCategory(),
          ShoesCategory(),
          BagsCategory(),
          ElectronicsCategory(),
          AccessoriesCategory(),
          HomeGardenCategory(),
          KidsCategory(),
          BeautyCategory()
        ],
      ),
    );
  }
}

class ItesmData {
  String label;
  bool isSelected;
  ItesmData({this.isSelected = false, required this.label});
}
