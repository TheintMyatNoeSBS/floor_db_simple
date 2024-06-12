import 'package:floor/floor.dart';

@Entity(tableName: 'items')
class ItemDto {
  @primaryKey
  final String itemID;
  final String itemName;
  final String active;
  final String createdBy;
  final String createdOn;
  final String modifiedBy;
  final String modifiedOn;

  ItemDto(
      {required this.itemID,
      required this.itemName,
      required this.active,
      required this.createdBy,
      required this.createdOn,
      required this.modifiedBy,
      required this.modifiedOn});
}
