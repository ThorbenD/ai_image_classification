import 'dart:io';
import 'package:ai_image_classification/models/train_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDescriptionDialog extends StatefulWidget {
  const ItemDescriptionDialog({Key? key}) : super(key: key);

  @override
  _ItemDescriptionDialogState createState() => _ItemDescriptionDialogState();
}

class _ItemDescriptionDialogState extends State<ItemDescriptionDialog> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final _image = _args['image'] as File?;
    final _classifiedObject = _args['classifiedObject'] as Train;
    final _confidence = _args['confidence'] as double?;

    return _confidence != null && _confidence > 0.9
        ? Scaffold(
            key: scaffoldKey,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: Stack(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 200,
                                viewportFraction: 1,
                                pageSnapping: true,
                              ),
                              items: _classifiedObject.images.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                      ),
                                      child: i,
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(20, 50, 20, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/');
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.photo,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/camera');
                                        },
                                      ),
                                    ],
                                  ),
                                  _image != null
                                      ? Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Container(
                                              width: 100,
                                              height: MediaQuery.of(context).size.height * 0.1,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEEEEEE),
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(width: 3),
                                              ),
                                              child: Image.file(
                                                _image,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 190, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x5B000000),
                                offset: Offset(0, -2),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _classifiedObject.name,
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF4B39EF)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFDBE2E7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFDBE2E7),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Model',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Gattung',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Zug erkannt',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: Text(
                                                      _classifiedObject.model,
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: Text(
                                                      _classifiedObject.category,
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: Text(
                                                      (_confidence * 100).toStringAsFixed(2) + '%',
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFDBE2E7),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 8),
                                                child: Text(
                                                  'Beschreibung',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            _classifiedObject.description,
                                            textAlign: TextAlign.start,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Zum Wikipedia-Artikel gehts hier:',
                                          textAlign: TextAlign.start,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 12),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEEEEEE),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _launchURL(_classifiedObject.link);
                                      },
                                      child: Text(
                                        '${_classifiedObject.name} auf Wikipedia',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: Stack(children: [
                          Image.file(_args['image'], fit: BoxFit.cover),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(20, 50, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.photo,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/camera');
                                  },
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 190, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x5B000000),
                                offset: Offset(0, -2),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Train was not identified.',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF4B39EF)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFDBE2E7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFDBE2E7),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Model',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Gattung',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  _confidence != null
                                                      ? Text(
                                                          'Zug erkannt',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: Text('-'),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: Text('-'),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: Text('-'),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFDBE2E7),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 100, 0, 200),
                                      child: Container(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
