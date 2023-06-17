import 'package:flutter/material.dart';

import '../widgets/fake_search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const FakeSearch(),
          elevation: 0,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(child: Text('Men')),
              Tab(child: Text('Women')),
              Tab(child: Text('Shoes')),
              Tab(child: Text('Bags')),
              Tab(child: Text('Electronics')),
              Tab(child: Text('Accessories')),
              Tab(child: Text('Home & Garden')),
              Tab(child: Text('Kids')),
              Tab(child: Text('Beauty')),
            ],
          ),
        ),
        body: const TabBarView(children: [
          Center(child: Text('Jedan')),
          Center(child: Text('Dva')),
          Center(child: Text('Tri')),
          Center(child: Text('Jedan')),
          Center(child: Text('Dva')),
          Center(child: Text('Tri')),
          Center(child: Text('Jedan')),
          Center(child: Text('Dva')),
          Center(child: Text('Tri')),
        ]),
      ),
    );
  }
}
