import 'package:retaste_app/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RestaurantDatabase {
  static const String dbName = 'restaurant_database.db';
  static const String restaurantTable = 'restaurants';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            ''' CREATE TABLE $restaurantTable(id TEXT PRIMARY KEY, name TEXT, description TEXT, pictureId TEXT, city TEXT, rating REAL, isFavorite INTEGER DEFAULT 0)''');
      },
    );
  }

  Future<void> insertRestaurant(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(restaurantTable, restaurant.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Restaurant>> getFavoriteRestaurants() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      restaurantTable,
      where: 'isFavorite = ?',
      whereArgs: [1],
    );

    return List.generate(maps.length, (index) {
      return Restaurant.fromJson(maps[index]);
    });
  }

  Future<void> toggleFavoriteStatus(String id, String name, String description,
      String pictureId, String city, double rating, bool isFavorite) async {
    final Database db = await database;

    if (isFavorite) {
      await db.insert(
        restaurantTable,
        {
          'id': id,
          'name': name,
          'description': description,
          'pictureId': pictureId,
          'city': city,
          'rating': rating,
          'isFavorite': 1
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      await db.delete(
        restaurantTable,
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  Future<bool> getFavoriteStatus(String id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      restaurantTable,
      columns: ['isFavorite'],
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty ? result[0]['isFavorite'] == 1 : false;
  }
}
