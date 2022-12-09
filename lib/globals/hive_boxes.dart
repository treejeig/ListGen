import 'package:hive/hive.dart';
import 'package:listgen/models/hive/main_list_item_hive.dart';

class HiveBoxes{
  static Box<MainListItemHive> getLocalList() =>
      Hive.box<MainListItemHive>("localListHiveBox");
}