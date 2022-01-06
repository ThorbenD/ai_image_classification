import 'dart:io';
import 'package:flutter/material.dart';

class CapturesScreen extends StatelessWidget {
  const CapturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _imageList = ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Captures',
                      style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: [
                      for (File imageFile in _imageList)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: InkWell(
                            onLongPress: () => _imageList.remove(imageFile),
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/image/classification', arguments: imageFile);
                            },
                            child: Image.file(
                              imageFile,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
