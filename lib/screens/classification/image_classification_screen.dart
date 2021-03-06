import 'dart:io';
import 'package:ai_image_classification/screens/item_catalog/components/item_catalog.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class ImageClassificationScreen extends StatefulWidget {
  @override
  State<ImageClassificationScreen> createState() => _ImageClassificationScreenState();
}

class _ImageClassificationScreenState extends State<ImageClassificationScreen> {
  _loadDataModelFromFile() async {
    await Tflite.loadModel(
      model: 'assets/tensorflow/model_unquant.tflite',
      labels: 'assets/tensorflow/labels.txt',
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  Future<dynamic> _predictImage(File image) async {
    await _loadDataModelFromFile();
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.5,
      imageMean: 0.0,
      imageStd: 255.0,
      asynch: true,
    );

    print(output);
    return output;
  }

  @override
  void initState() {
    super.initState();
    _loadDataModelFromFile();
  }

  @override
  Widget build(BuildContext context) {
    final XFile _image = ModalRoute.of(context)!.settings.arguments as XFile;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<dynamic>(
              future: _predictImage(File(_image.path)),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                List<Widget> children = <Widget>[];
                if (snapshot.hasData) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    Navigator.pushReplacementNamed(context, '/item/description',
                        arguments: {
                          'image': File(_image.path),
                          'classifiedObject': ItemCatalog.allTrains[snapshot.data[0]['index']],
                          'confidence': snapshot.data[0]['confidence'],
                        });
                  });
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ];
                }
                return Center(
                  child: Container(
                    color: Colors.grey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
