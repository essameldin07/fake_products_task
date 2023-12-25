import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:products/database/cart_dao.dart';
import 'package:products/models/cart_model.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 2, entities: [CartModel])
abstract class AppDatabase extends FloorDatabase {
  CartDao get cartDao;

  static Future<AppDatabase> getInctance() async {
    return await $FloorAppDatabase.databaseBuilder('app_database1.db').build();
  }
}
