import 'package:ai_image_classification/screens/camera/camera_screen.dart';
import 'package:ai_image_classification/screens/captures_screen.dart';
import 'package:ai_image_classification/screens/item_catalog/item_catalog_screen.dart';
import 'package:flutter/material.dart';

class QuickLinkContainer extends StatelessWidget {
  const QuickLinkContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Container(
        decoration: backgroundBox,
        padding: EdgeInsets.all(8),
        child: GridView(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1.5,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemCatalogScreen(),
                ),
              ),
              child: Container(
                decoration: itemBox,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_tree_sharp,
                      color: Colors.lightBlueAccent,
                      size: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('Catalog'),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraScreen(),
                ),
              ),
              child: Container(
                decoration: itemBox,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      color: Colors.lightGreenAccent,
                      size: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('Capture'),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CapturesScreen(imageFileList: []),
                  ),
                );
              },
              child: Container(
                decoration: itemBox,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo,
                      color: Colors.amberAccent,
                      size: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('Select'),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              child: Container(
                decoration: itemBox,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings_rounded,
                      color: Colors.grey,
                      size: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('Settings'),
                    )
                  ],
                ),
              ),
            ),
            // InkWell(
            //   child: Container(
            //     decoration: itemBox,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.max,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.stacked_line_chart_rounded,
            //           size: 24,
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(top: 4),
            //           child: Text('Activity'),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // InkWell(
            //   child: Container(
            //     decoration: itemBox,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.max,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.stacked_line_chart_rounded,
            //           size: 24,
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(top: 4),
            //           child: Text('Activity'),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // InkWell(
            //   child: Container(
            //     decoration: itemBox,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.max,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.stacked_line_chart_rounded,
            //           size: 24,
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(top: 4),
            //           child: Text('Activity'),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // InkWell(
            //   child: Container(
            //     decoration: itemBox,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.max,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.stacked_line_chart_rounded,
            //           size: 24,
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(top: 4),
            //           child: Text('Activity'),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  get itemBox => BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.redAccent,
      );

  get backgroundBox => BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      );
}
