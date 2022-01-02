import 'package:ai_image_classification/models/train_model.dart';
import 'package:ai_image_classification/utils/helpers/db_helper.dart';
import 'package:flutter/material.dart';

class ItemsListingScreen extends StatefulWidget {
  const ItemsListingScreen({Key? key}) : super(key: key);

  @override
  _ItemsListingScreenState createState() => _ItemsListingScreenState();
}

class _ItemsListingScreenState extends State<ItemsListingScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DBHelper? dbHelper;
  List<Train>? items;

  @override
  void initState() {
    dbHelper = DBHelper();
    super.initState();
  }

  Future showData() async {
    items = await dbHelper!.getAll();
    setState(() {
      items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: items?.length ?? 0,
        itemBuilder: (context, i) {
          return Dismissible(
            key: Key(items![i].name),
            onDismissed: (direction) {
              String strName = items![i].name;
              dbHelper!.delete(i);
              setState(() {
                items!.removeAt(i);
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$strName deleted")));
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.redAccent,
                //child: items![i].bytes != null ? Image.memory(items![i].!) : Text(items![i].name[0]),
              ),
              title: Text(items?[i].name ?? ''),
              subtitle: Text(items?[i].description ?? ''),
            ),
          );
        },
      ),
    );
  }

  Row listItem(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color(0xFFC8CED5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 4, 0),
                            child: Text(
                              'Description',
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
      ],
    );
  }
}
