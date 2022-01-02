import 'package:ai_image_classification/models/train_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database? _db;
  static const String DB_NAME = 'train.db';
  static const String TABLE = 'trains';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String DESCRIPTION = 'description';
  static const String IMAGE = 'image';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $NAME TEXT, $DESCRIPTION TEXT, $IMAGE TEXT)');
  }

  Future<Train> add(Train train) async {
    var dbClient = await db;
    train.id = await dbClient!.insert(TABLE, train.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return train;
  }

  Future<Train?> getTrainBy(String name) async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
        await dbClient!.query(TABLE, columns: [ID, NAME, DESCRIPTION, IMAGE], where: '$NAME = ?', whereArgs: [name]);
    if (maps.length > 0) {
      return Train.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Train>> getAll() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient!.query(TABLE, columns: [ID, NAME, DESCRIPTION, IMAGE]);
    return List.generate(maps.length, (i) => Train.fromMap(maps[i]));
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(
      TABLE,
      where: '$ID = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Train train) async {
    var dbClient = await db;
    return await dbClient!.update(
      TABLE,
      train.toMap(),
      where: '$ID = ?',
      whereArgs: [train.id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
