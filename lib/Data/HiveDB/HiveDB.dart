import 'package:hive/hive.dart';

class HiveDB {
  isExists({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return length != 0;
  }

  getBoxes<T>(String boxName) async {
    List<T> boxList = <T>[];

    final openBox = await Hive.openBox(boxName);

    int length = openBox.length;

    for (int i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }
    return boxList;
  }

  addOneBox<BranchModel>(items, String boxName) async {
    final openBox = await Hive.openBox(boxName);

    openBox.put(items.id, items);
  }

   Future<dynamic> getOneBox(String boxName, int key) async {
    final openBox = await Hive.openBox(boxName);
    return openBox.get(key);
  }

  deleteBox<Void>(String boxName, id) async {
    final openBox = await Hive.openBox(boxName);

    openBox.delete(id);
  }
}
