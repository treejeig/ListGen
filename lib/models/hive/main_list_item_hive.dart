import 'package:hive/hive.dart';
import 'package:listgen/models/hive/sub_list_item_hive.dart';

part 'main_list_item_hive.g.dart';

@HiveType(typeId: 1)
class MainListItemHive extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String note;
  @HiveField(3)
  late List<SubListItemHive> checkedItems;
  @HiveField(4)
  late List<SubListItemHive> uncheckedItems;
}
