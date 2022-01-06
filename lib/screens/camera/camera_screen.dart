import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras = [];

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {
  CameraController? controller;
  File? _imageFile;
  ImagePicker imagePicker = ImagePicker();

  bool _isCameraInitialized = false;
  bool _isRearCameraSelected = true;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 2.0;

  double _currentZoomLevel = 1.0;
  FlashMode? _currentFlashMode;

  List<File> allFileList = [];

  final resolutionPresets = ResolutionPreset.values;
  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  refreshAlreadyCapturedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();
    List<Map<int, dynamic>> fileNames = [];

    fileList.forEach((file) {
      if (file.path.contains('.jpg')) {
        allFileList.add(File(file.path));

        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    });

    if (fileNames.isNotEmpty) {
      final recentFile = fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
      String recentFileName = recentFile[1];
      _imageFile = File('${directory.path}/$recentFileName');

      setState(() {});
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;

    if (cameraController!.value.isTakingPicture) {
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occurred while taking picture: $e');
      return null;
    }
  }

  Future<XFile?> _imgFromGallery() async {
    try {
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
        maxHeight: 600,
      );

      if (pickedFile != null) {
        return XFile(pickedFile.path);
      }
    } on PlatformException catch (e) {
      print('Error occurred while picking image: $e');
      return null;
    }
  }

  void resetCameraValues() async {
    _currentZoomLevel = 1.0;
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    resetCameraValues();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
      await Future.wait([
        cameraController.getMaxZoomLevel().then((value) => _maxAvailableZoom = value),
        cameraController.getMinZoomLevel().then((value) => _minAvailableZoom = value),
      ]);

      _currentFlashMode = controller!.value.flashMode;
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    onNewCameraSelected(cameras[0]);
    refreshAlreadyCapturedImages();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                _isRearCameraSelected ? Icons.camera_front : Icons.camera_rear,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  _isCameraInitialized = false;
                });
                onNewCameraSelected(cameras[_isRearCameraSelected ? 1 : 0]);
                setState(() {
                  _isRearCameraSelected = !_isRearCameraSelected;
                });
              },
            ),
          ],
        ),
        body: _isCameraInitialized
            ? Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.1 / controller!.value.aspectRatio,
                    child: Stack(
                      children: [
                        controller!.buildPreview(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            8.0,
                            16.0,
                            8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Slider(
                                      value: _currentZoomLevel,
                                      min: _minAvailableZoom,
                                      max: _maxAvailableZoom,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.white30,
                                      onChanged: (value) async {
                                        setState(() {
                                          _currentZoomLevel = value;
                                        });
                                        await controller!.setZoomLevel(value);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _currentZoomLevel.toStringAsFixed(1) + 'x',
                                          style: TextStyle(color: Colors.white),
                                        ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                          onPressed: _currentFlashMode == FlashMode.off
                              ? () async {
                                  setState(() {
                                    _currentFlashMode = FlashMode.off;
                                  });
                                  await controller!.setFlashMode(
                                    FlashMode.off,
                                  );
                                }
                              : () async {
                                  setState(() {
                                    _currentFlashMode = FlashMode.auto;
                                  });
                                  await controller!.setFlashMode(
                                    FlashMode.auto,
                                  );
                                },
                          icon: Icon(
                            _currentFlashMode == FlashMode.off ? Icons.flash_off : Icons.flash_on,
                            color: Colors.white,
                            size: 30,
                          )),
                      IconButton(
                        onPressed: () async {
                          XFile? rawImage = await takePicture();
                          if(rawImage == null) return;
                          Navigator.pushReplacementNamed(context, '/camera/classification', arguments: rawImage);
                        },
                        iconSize: 50,
                        icon: Icon(
                          Icons.circle,
                          color: Colors.white38,
                          size: 50,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          XFile? rawImage = await _imgFromGallery();
                          if(rawImage == null) return;
                          Navigator.pushReplacementNamed(context, '/camera/classification', arguments: rawImage);
                        },
                        child: Container(
                          width: 55,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            image: DecorationImage(
                                    image: AssetImage('assets/images/sbahn/sbahn_00.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            : Center(
                child: Text(
                  'LOADING',
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }

  Future<void> saveFileToAppDirectory(XFile rawImage) async {
    File imageFile = File(rawImage.path);
    int currentUnix = DateTime.now().millisecondsSinceEpoch;
    final directory = await getApplicationDocumentsDirectory();

    String fileFormat = imageFile.path.split('.').last;

    print(fileFormat);
    // await imageFile.copy(
    //   '${directory.path}/$currentUnix.$fileFormat',
    // );

    refreshAlreadyCapturedImages();
  }
}
