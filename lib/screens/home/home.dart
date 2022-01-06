import 'package:ai_image_classification/screens/home/components/user_container.dart';
import 'package:ai_image_classification/screens/item_catalog/item_catalog_screen.dart';
import 'package:ai_image_classification/screens/item_catalog/items_listing_screen.dart';
import '../item_catalog/components/item_catalog.dart';
import 'components/quick_link_container.dart';
import 'package:flutter/material.dart';
import '../bottom_navigation_bar.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageWidget> with TickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        UserContainer(),
        QuickLinkContainer(),
        ItemCatalog(),
      ],
    ),
    ItemsListingScreen(),
    ItemCatalogScreen(),
    Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        UserContainer(),
        Expanded(
          child: Center(
            child: Text('User-Settings in development.'),
          ),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/camera');
        },
        child: Icon(
          Icons.add_a_photo,
          color: Colors.lightGreenAccent,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABIntegratedNavBar(
        backgroundColor: Colors.redAccent,
        onTabSelected: (index) => setState(() => _currentIndex = index),
        centerItemText: '',
        color: Colors.white,
        selectedColor: Colors.lightBlueAccent,
        notchedShape: CircularNotchedRectangle(),
        items: [
          NavigationBarItem(iconData: Icons.home, text: 'Home'),
          NavigationBarItem(iconData: Icons.search, text: 'Search'),
          NavigationBarItem(iconData: Icons.book, text: 'Catalog'),
          NavigationBarItem(iconData: Icons.list, text: 'More'),
        ],
      ),
    );
  }
}
