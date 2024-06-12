// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
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

  ItemDao? _itemDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
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
            'CREATE TABLE IF NOT EXISTS `items` (`itemID` TEXT NOT NULL, `itemName` TEXT NOT NULL, `active` TEXT NOT NULL, `createdBy` TEXT NOT NULL, `createdOn` TEXT NOT NULL, `modifiedBy` TEXT NOT NULL, `modifiedOn` TEXT NOT NULL, PRIMARY KEY (`itemID`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ItemDao get itemDao {
    return _itemDaoInstance ??= _$ItemDao(database, changeListener);
  }
}

class _$ItemDao extends ItemDao {
  _$ItemDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _itemDtoInsertionAdapter = InsertionAdapter(
            database,
            'items',
            (ItemDto item) => <String, Object?>{
                  'itemID': item.itemID,
                  'itemName': item.itemName,
                  'active': item.active,
                  'createdBy': item.createdBy,
                  'createdOn': item.createdOn,
                  'modifiedBy': item.modifiedBy,
                  'modifiedOn': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ItemDto> _itemDtoInsertionAdapter;

  @override
  Future<List<ItemDto>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM items',
        mapper: (Map<String, Object?> row) => ItemDto(
            itemID: row['itemID'] as String,
            itemName: row['itemName'] as String,
            active: row['active'] as String,
            createdBy: row['createdBy'] as String,
            createdOn: row['createdOn'] as String,
            modifiedBy: row['modifiedBy'] as String,
            modifiedOn: row['modifiedOn'] as String));
  }

  @override
  Future<ItemDto?> findByItemID(String itemID) async {
    return _queryAdapter.query('SELECT * FROM items where itemID =?1',
        mapper: (Map<String, Object?> row) => ItemDto(
            itemID: row['itemID'] as String,
            itemName: row['itemName'] as String,
            active: row['active'] as String,
            createdBy: row['createdBy'] as String,
            createdOn: row['createdOn'] as String,
            modifiedBy: row['modifiedBy'] as String,
            modifiedOn: row['modifiedOn'] as String),
        arguments: [itemID]);
  }

  @override
  Future<void> deleteItem(String itemID) async {
    await _queryAdapter.queryNoReturn('Delete from items where itemID =?1',
        arguments: [itemID]);
  }

  @override
  Future<void> insertOne(ItemDto item) async {
    await _itemDtoInsertionAdapter.insert(item, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertMany(List<ItemDto> items) {
    return _itemDtoInsertionAdapter.insertListAndReturnIds(
        items, OnConflictStrategy.replace);
  }
}
