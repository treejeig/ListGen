import 'package:hive/hive.dart';


part 'sub_list_item_hive.g.dart';

@HiveType(typeId: 2)
class SubListItemHive extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  bool isChecked = false;

}
