import 'package:auto_route/auto_route.dart';
import 'package:floor_db_simple/item/shared/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../infrastructure/model/item_dto.dart';

@RoutePage()
class ItemDetailPage extends ConsumerStatefulWidget {
  const ItemDetailPage({super.key});

  @override
  ConsumerState<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends ConsumerState<ItemDetailPage> {
  final _itemNameController = TextEditingController();
  final _itemNameFocusNode = FocusNode();

  List<ItemDto> items = [];
  @override
  void initState() {
    super.initState();
    Future.microtask(() => fetchItems());
  }

  Future<void> fetchItems() async {
    var itemData = await ref.watch(itemLocalServiceProvider).getAllItems();
    setState(() {
      items.addAll(itemData);
    });
  }

  Future<void> addItem() async {
    var item = ItemDto(
        itemID: const Uuid().v1().toString(),
        itemName: _itemNameController.text,
        active: "True",
        createdBy: "1",
        createdOn: DateFormat("dd-MM-yyyy hh:ss").format(DateTime.now()),
        modifiedBy: "1",
        modifiedOn: DateFormat("dd-MM-yyyy hh:ss").format(DateTime.now()));

    await ref.watch(itemLocalServiceProvider).addOne(item);
    fetchItems();
  }

  void showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Add Item",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.blue),
          ),
          content: Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _itemNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Item Name',
                  ),
                  focusNode: _itemNameFocusNode,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey),
                        child: const Text(
                          "Cancel",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 4),
                    child: InkWell(
                      onTap: () {
                        addItem();
                        _itemNameController.text = "";
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.orange.shade400),
                        child: const Text(
                          "Save",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showAddDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            color: Colors.blueAccent,
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    "Item Name",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Delete",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey.shade300,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              items[index].itemName,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const Expanded(
                            child: Icon(
                              Icons.delete_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
