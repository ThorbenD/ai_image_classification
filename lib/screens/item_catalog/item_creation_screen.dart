import 'package:ai_image_classification/models/train_model.dart';
import 'package:ai_image_classification/utils/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemCreationScreen {
  ImagePicker imagePicker = ImagePicker();
  final txtName = TextEditingController();
  final txtDescription = TextEditingController();

  Widget buildAlert(BuildContext context, Train item, bool isNew) {
    DBHelper helper = DBHelper();
    if (!isNew) {
      txtName.text = item.name;
      txtDescription.text = item.description;
    }
    return AlertDialog(
      title: Text((isNew) ? 'Add train' : 'Edit train'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            IconButton(
              onPressed: () async {
                var image = await imagePicker.pickImage(
                    source: ImageSource.gallery, imageQuality: 50);
                if (image != null) {
                  image.readAsBytes().then((bytes) {
                    //item.bytes = bytes;
                  });
                }
              },
              icon: Icon(
                Icons.image,
                size: 25,
              ),
            ),
            TextField(
              controller: txtName,
              decoration: InputDecoration(hintText: 'Model name'),
            ),
            TextField(
              controller: txtDescription,
              decoration: InputDecoration(hintText: 'Description'),
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                item.name = txtName.text;
                item.description = txtDescription.text;
                helper.add(item);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
