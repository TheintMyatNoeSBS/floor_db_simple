import '../model/item_dto.dart';
import 'dao/item_dao.dart';

class ItemLocalService {
  final ItemDao _dao;

  ItemLocalService(this._dao);

  Future<List<ItemDto>> getAllItems() async {
    return await _dao.findAll();
  }

  Future<ItemDto?> getItemByItemID(String itemID) async {
    return await _dao.findByItemID(itemID);
  }

  Future<void> addOne(ItemDto item) async {
    await _dao.insertOne(item);
  }

  Future<List<int>> addAll(List<ItemDto> items) async {
    return await _dao.insertMany(items);
  }

  Future<void> deleteItem(String itemID) async {
    return await _dao.deleteItem(itemID);
  }
}
