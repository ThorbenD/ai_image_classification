import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'screens/camera/camera_screen.dart';
import 'screens/classification/image_classification_screen.dart';
import 'screens/classification/item_description_dialog.dart';
import 'screens/home/home.dart';
import 'screens/item_catalog/item_catalog_screen.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePageWidget(),
        '/camera': (context) => CameraScreen(),
        // '/camera/captures': (context) => CapturesScreen(imageFileList: null),
        '/camera/classification': (context) => ImageClassificationScreen(),
        '/item/catalog': (context) => ItemCatalogScreen(),
        '/item/description': (context) => ItemDescriptionDialog(),
      },
    );
  }
}
