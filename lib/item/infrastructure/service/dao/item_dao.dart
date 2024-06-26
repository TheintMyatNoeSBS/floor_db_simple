import 'package:floor/floor.dart';
import 'package:floor_db_simple/item/infrastructure/model/item_dto.dart';

@dao
abstract class ItemDao {
  @Query('SELECT * FROM items')
  Future<List<ItemDto>> findAll();

  @Query('SELECT * FROM items where itemID =:itemID')
  Future<ItemDto?> findByItemID(String itemID);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOne(ItemDto item);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertMany(List<ItemDto> items);

  @Query('Delete from items where itemID =:itemID')
  Future<void> deleteItem(String itemID);
}
