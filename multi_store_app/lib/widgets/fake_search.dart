import 'package:flutter/material.dart';

import '../common_screens/search_screen.dart';

class FakeSearch extends StatelessWidget {
  const FakeSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchScreen(),
            ));
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(Icons.search),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'What are you looking for?',
                style: TextStyle(fontSize: 14),
              ),
            ),
            const Spacer(),
            Container(
              width: 70,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
              ),
              child: const Center(
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
