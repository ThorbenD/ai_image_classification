class TrainList {
  int id;
  String name;
  int category;

  TrainList(this.id, this.name, this.category);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'priority': category,
    };
  }
}
