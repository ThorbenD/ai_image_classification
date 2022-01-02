import 'package:ai_image_classification/screens/home/components/user_container.dart';
import 'package:ai_image_classification/screens/item_catalog/item_catalog_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          UserContainer(),
          QuickLinkContainer(),
          ItemCatalog(),
        ],
      ),
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
        onTabSelected: (int value) {},
        centerItemText: '',
        color: Colors.white,
        selectedColor: Colors.lightBlueAccent,
        notchedShape: CircularNotchedRectangle(),
        items: [
          NavigationBarItem(iconData: Icons.home, text: 'Home', className: HomePageWidget()),
          NavigationBarItem(iconData: Icons.search, text: 'Search', className: HomePageWidget()),
          NavigationBarItem(iconData: Icons.book, text: 'Catalog', className: ItemCatalogScreen()),
          NavigationBarItem(iconData: Icons.list, text: 'More', className: HomePageWidget()),
        ],
      ),
    );
  }
}
