import 'package:flutter/cupertino.dart';

class Train {
  int id = 0;
  String name = '';
  String model = '';
  String category = '';
  String description = '';
  List<Image> images = [];
  String link = '';

  Train(this.id, this.name, this.model, this.category, this.description, this.images, this.link);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id == 0 ? null : id,
      'name': name,
      'model': model,
      'category': category,
      'description': description,
      'image': images.map((image) => image).toList(),
      'link': link,
    };
    return map;
  }

  Train.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'] ?? '';
    model = map['model'] ?? '';
    category = map['category'] ?? '';
    description = map['description'] ?? '';
    images = map['image']?.map<Image>((i) => i)?.toList() ?? [];
    link = map['link'] ?? '';
  }
}
