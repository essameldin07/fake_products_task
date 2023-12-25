// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CartDao? _cartDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CartModel` (`id` INTEGER NOT NULL, `productId` INTEGER NOT NULL, `title` TEXT NOT NULL, `quantity` INTEGER NOT NULL, `price` REAL NOT NULL, `image` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CartDao get cartDao {
    return _cartDaoInstance ??= _$CartDao(database, changeListener);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _cartModelInsertionAdapter = InsertionAdapter(
            database,
            'CartModel',
            (CartModel item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'title': item.title,
                  'quantity': item.quantity,
                  'price': item.price,
                  'image': item.image
                }),
        _cartModelUpdateAdapter = UpdateAdapter(
            database,
            'CartModel',
            ['id'],
            (CartModel item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'title': item.title,
                  'quantity': item.quantity,
                  'price': item.price,
                  'image': item.image
                }),
        _cartModelDeletionAdapter = DeletionAdapter(
            database,
            'CartModel',
            ['id'],
            (CartModel item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'title': item.title,
                  'quantity': item.quantity,
                  'price': item.price,
                  'image': item.image
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CartModel> _cartModelInsertionAdapter;

  final UpdateAdapter<CartModel> _cartModelUpdateAdapter;

  final DeletionAdapter<CartModel> _cartModelDeletionAdapter;

  @override
  Future<List<CartModel>> findAllCart() async {
    return _queryAdapter.queryList('SELECT * FROM CartModel',
        mapper: (Map<String, Object?> row) => CartModel(
            id: row['id'] as int,
            productId: row['productId'] as int,
            title: row['title'] as String,
            price: row['price'] as double,
            image: row['image'] as String,
            quantity: row['quantity'] as int));
  }

  @override
  Future<CartModel?> findCartById(int id) async {
    return _queryAdapter.query('SELECT * FROM CartModel WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CartModel(
            id: row['id'] as int,
            productId: row['productId'] as int,
            title: row['title'] as String,
            price: row['price'] as double,
            image: row['image'] as String,
            quantity: row['quantity'] as int),
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM CartModel');
  }

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM CartModel WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertCart(CartModel cart) async {
    await _cartModelInsertionAdapter.insert(cart, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCart(CartModel cart) async {
    await _cartModelUpdateAdapter.update(cart, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCart(CartModel cart) async {
    await _cartModelDeletionAdapter.delete(cart);
  }
}
