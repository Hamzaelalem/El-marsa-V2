import 'package:el_marsa/constance.dart';
import 'package:el_marsa/model/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/cart_product_model.dart';

class CartDbHelper {
  // Singleton
  CartDbHelper._();

  Future<void> deleteDatabase(String path) async {
    String path = await getDatabasesPath() + 'CartProduct2.db';
    await deleteDatabase(path);
    _database = null;
  }

  // Instance
  static final CartDbHelper db = CartDbHelper._();

  static Database? _database;

  // Initialize database
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();
    return _database;
  }

  Future<List<CartProductModel>?> getAllProduct() async {
    var dbClient = await database;
    List<Map<String, Object?>>? maps = await dbClient?.query(tableCartProduct);
    List<CartProductModel> list = maps!.isNotEmpty
        ? maps.map((product) => CartProductModel.fromJson(product)).toList()
        : [];
    return list;
  }

  // Future<Database> from GPT
  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'CartProduct2.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE $tableCartProduct(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnproductId TEXT,
          $columnName TEXT ,
            $columnPrice TEXT,
            $columnQty INTEGER ,
            $columnImage TEXT 
        )
      ''');
    });
  }

  insert(CartProductModel model) async {
    var dbClient = await database;
    await dbClient?.insert(
      tableCartProduct,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  updadteProduct(CartProductModel model) async {
    var dbClient = await database;
    return await dbClient?.update(tableCartProduct, model.toJson(),
        where: '$columnproductId=?', whereArgs: [model.productId]);
  }

  final String tableCartProduct = 'CartProduct';
  final String columnId = 'id';
  final String columnproductId = 'productId';
  final String columnName = 'name';
  final String columnPrice = 'price';
  final String columnQty = 'qty';
  final String columnImage = 'image';
}
