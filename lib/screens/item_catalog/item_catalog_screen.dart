import 'package:ai_image_classification/screens/home/home.dart';
import 'package:ai_image_classification/screens/item_catalog/components/item_catalog.dart';
import 'package:ai_image_classification/screens/bottom_navigation_bar.dart';
import 'package:ai_image_classification/screens/item_catalog/items_listing_screen.dart';
import 'package:flutter/material.dart';
import 'package:ai_image_classification/screens/camera/camera_screen.dart';

class ItemCatalogScreen extends StatelessWidget {
  ItemCatalogScreen({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          backgroundColor: Colors.redAccent,
          // The search area here
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemsListingScreen(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search), hintText: 'Search...', border: InputBorder.none),
                  ),
                ),
              )),
          // actions: <Widget>[
          //   IconButton(
          //     icon: const Icon(Icons.add),
          //     onPressed: () {
          //       showDialog(
          //         context: context,
          //         //builder: (BuildContext context) => itemCreationScreen.buildAlert(context, Train(0, "", "", null), true),
          //       );
          //     },
          //   ),
          // ]
      ),
      body: Column(
        children: [
          ItemCatalog(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CameraScreen(),
            ),
          );
        },
        child: Icon(Icons.add_a_photo),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABIntegratedNavBar(
        backgroundColor: Colors.redAccent,
        onTabSelected: (int value) {},
        centerItemText: '',
        color: Colors.white,
        selectedColor: Colors.blue,
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
