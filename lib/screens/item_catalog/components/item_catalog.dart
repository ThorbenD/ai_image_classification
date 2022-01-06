import 'package:ai_image_classification/models/train_model.dart';
import 'package:flutter/material.dart';

class ItemCatalog extends StatelessWidget {
  ItemCatalog({Key? key}) : super(key: key);

  static List<Train> allTrains = [
    new Train(
        0,
        "Intercity Express 1 (ICE 1)",
        "Intercity Express",
        "Hochgeschwindigkeitszug",
        "Der erste Intercity Express der deutschen Bahn.",
        [
          const Image(image: AssetImage("assets/images/ice/ice1_00.jpeg")),
          const Image(image: AssetImage("assets/images/ice/ice1_01.jpeg")),
          const Image(image: AssetImage("assets/images/ice/ice1_02.jpeg")),
        ],
        "https://de.wikipedia.org/wiki/ICE_1"),
    new Train(
        1,
        "TGV Duplex",
        "Franz. Zug",
        "Hochgeschwindigkeitszug",
        "Der TGV ist ein bekanntes Fahrzeug aus Frankreich.",
        [
          const Image(image: AssetImage("assets/images/tgv/tgv_00.jpeg")),
          const Image(image: AssetImage("assets/images/tgv/tgv_01.jpeg")),
          const Image(image: AssetImage("assets/images/tgv/tgv_02.jpeg")),
        ],
        "https://de.wikipedia.org/wiki/TGV_Duplex"),
    new Train(
        2,
        "Baureihe 425 (S-Bahn)",
        "S-Bahn",
        "Regional-Bahn",
        "Die Baureihe 425 ist ein Modell der S-Bahn aus Deutschland.",
        [
          const Image(image: AssetImage("assets/images/sbahn/sbahn_00.jpeg")),
          const Image(image: AssetImage("assets/images/sbahn/sbahn_01.jpeg")),
          const Image(image: AssetImage("assets/images/sbahn/sbahn_02.jpeg")),
        ],
        "https://de.wikipedia.org/wiki/S-Bahn"),
    new Train(
        3,
        "Süwex RE",
        "Südwest-Express",
        "RegionalBahn",
        "Regionalbahn der Eisenbahngesellschaften im Südwesten von Deutschland.",
        [
          const Image(image: AssetImage("assets/images/suewex/suewex_00.jpeg")),
          const Image(image: AssetImage("assets/images/suewex/suewex_01.jpeg")),
          const Image(image: AssetImage("assets/images/suewex/suewex_02.jpeg")),
        ],
        Uri.encodeFull('https://de.wikipedia.org/wiki/SÜWEX').toString()),
  ];

  get itemBox => BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.redAccent,
      );

  get backgroundBox => BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Container(
        decoration: backgroundBox,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [Text('Train Catalog')],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.5,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/item/description', arguments: {
                          'image': null,
                          'classifiedObject': allTrains[0],
                          'confidence': 1.0,
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          image: DecorationImage(
                            image: AssetImage("assets/images/ice/ice1_00.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'ICE 1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/item/description', arguments: {
                          'image': null,
                          'classifiedObject': allTrains[1],
                          'confidence': 1.0,
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          image: DecorationImage(
                            image: AssetImage("assets/images/tgv/tgv_00.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'TGV Duplex',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/item/description', arguments: {
                          'image': null,
                          'classifiedObject': allTrains[2],
                          'confidence': 1.0,
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          image: DecorationImage(
                            image: AssetImage("assets/images/sbahn/sbahn_00.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'S-Bahn',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/item/description', arguments: {
                          'image': null,
                          'classifiedObject': allTrains[3],
                          'confidence': 1.0,
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          image: DecorationImage(
                            image: AssetImage("assets/images/suewex/suewex_00.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Süwex RE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
