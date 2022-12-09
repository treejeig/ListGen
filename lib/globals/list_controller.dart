import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listgen/globals/hive_boxes.dart';
import 'package:listgen/globals/global_variables.dart';
import 'package:listgen/models/hive/main_list_item_hive.dart';
import 'package:listgen/models/hive/sub_list_item_hive.dart';


final listProvider = ChangeNotifierProvider<ListController>((ref) {
  return ListController();
});

class ListController extends ChangeNotifier {
  String selectedMainListItemId = "";
  String selectedSubListItemId = "";
  TextEditingController mainListItemNameController = TextEditingController();
  TextEditingController mainListItemNoteController = TextEditingController();
  TextEditingController subListItemNameController = TextEditingController();
  FocusNode mainListItemNameFocusNode = FocusNode();
  FocusNode mainListItemNoteFocusNode = FocusNode();
  FocusNode subListItemNameFocusNode = FocusNode();


  addMainListItem() {
    String id = generateId();
    localListHiveBox.put(id,
        MainListItemHive()
          ..id=id
          ..name=mainListItemNameController.text
          ..note=mainListItemNoteController.text
          ..checkedItems=[]
          ..uncheckedItems=[]);
    clearInputFields();
  }

  addSubListItem() async {
    MainListItemHive mainListItemHive = HiveBoxes.getLocalList().get(selectedMainListItemId)!;
    mainListItemHive.uncheckedItems.add(SubListItemHive()..id=generateId()..name=subListItemNameController.text);
    mainListItemHive.save();
    clearInputFields();
    subListItemNameFocusNode.requestFocus();
  }

  updateMainListItem() async {
    MainListItemHive mainListItemHive = HiveBoxes.getLocalList().get(selectedMainListItemId)!;
    mainListItemHive.name = mainListItemNameController.text;
    mainListItemHive.note = mainListItemNoteController.text;
    mainListItemHive.save();
    clearInputFields();
  }

  updateSubListItem() async {
    MainListItemHive mainListItemHive = await HiveBoxes.getLocalList().get(selectedMainListItemId)!;
    bool isCheckedList = false;
    await checkIsCheckedList().then((value) => isCheckedList=value);
    isCheckedList
        ? mainListItemHive.checkedItems.firstWhere((subListItem) => subListItem.id == selectedSubListItemId).name = subListItemNameController.text
        : mainListItemHive.uncheckedItems.firstWhere((subListItem) => subListItem.id == selectedSubListItemId).name = subListItemNameController.text;
    mainListItemHive.save();
    clearInputFields();
  }

  deleteMainListItem() async {
    MainListItemHive mainListItemHive = await HiveBoxes.getLocalList().get(selectedMainListItemId)!;
    mainListItemHive.delete();
  }

  deleteSubListItem() async {
    MainListItemHive mainListItemHive = await HiveBoxes.getLocalList().get(selectedMainListItemId)!;
    bool isCheckedList = false;
    await checkIsCheckedList().then((value) => isCheckedList=value);
    isCheckedList
        ? mainListItemHive.checkedItems.removeWhere((subListItem) => subListItem.id == selectedSubListItemId)
        : mainListItemHive.uncheckedItems.removeWhere((subListItem) => subListItem.id == selectedSubListItemId);
    mainListItemHive.save();
  }

  setSelectedMainListItem(String id) async {
    selectedMainListItemId = id;
    MainListItemHive mainListItemHive = await HiveBoxes.getLocalList().get(selectedMainListItemId)!;
    mainListItemNameController.text = mainListItemHive.name;
    mainListItemNoteController.text = mainListItemHive.note;
    notifyListeners();
  }

  setSelectedSubListItem(String id) async {
    selectedSubListItemId = id;
    MainListItemHive mainListItemHive = await HiveBoxes.getLocalList().get(selectedMainListItemId)!;
    bool isCheckedList = false;
    await checkIsCheckedList().then((value) => isCheckedList=value);
    subListItemNameController.text = isCheckedList
        ? mainListItemHive.checkedItems.firstWhere((subListItem) => subListItem.id == selectedSubListItemId).name
        : mainListItemHive.uncheckedItems.firstWhere((subListItem) => subListItem.id == selectedSubListItemId).name;
    notifyListeners();
  }

  setSubListItemCheck() async {
    MainListItemHive mainListItemHive = await HiveBoxes.getLocalList().get(selectedMainListItemId)!;
    bool isCheckedList = false;
    await checkIsCheckedList().then((value) => isCheckedList=value);
    if (isCheckedList) {
      SubListItemHive subListItem = mainListItemHive.checkedItems.firstWhere((subListItem) => subListItem.id == selectedSubListItemId);
      subListItem.isChecked = !isCheckedList;
      mainListItemHive.checkedItems.removeWhere((subListItem) => subListItem.id == selectedSubListItemId);
      mainListItemHive.uncheckedItems.add(subListItem);
    } else {
      SubListItemHive subListItem = mainListItemHive.uncheckedItems.firstWhere((subListItem) => subListItem.id == selectedSubListItemId);
      subListItem.isChecked = !isCheckedList;
      mainListItemHive.uncheckedItems.removeWhere((subListItem) => subListItem.id == selectedSubListItemId);
      mainListItemHive.checkedItems.add(subListItem);
    }
    mainListItemHive.save();
  }

  clearInputFields() {
    mainListItemNameController.clear();
    mainListItemNoteController.clear();
    subListItemNameController.clear();
  }

  deleteSubListItems(SubListType subListType) async {
    MainListItemHive mainListItemHive = await HiveBoxes.getLocalList().get(selectedMainListItemId)!;
    subListType==SubListType.Checked ? mainListItemHive.checkedItems.clear() : mainListItemHive.uncheckedItems.clear();
    mainListItemHive.save();
  }

  String generateId() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  Future<bool> checkIsCheckedList() async {
    MainListItemHive mainListItemHive = await HiveBoxes.getLocalList().get(selectedMainListItemId)!;
    return mainListItemHive.checkedItems.any((subListItem) => subListItem.id == selectedSubListItemId);
  }
}
