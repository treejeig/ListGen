import 'package:flutter/material.dart';
import 'package:listgen/models/hive/main_list_item_hive.dart';
import 'package:listgen/globals/global_functions.dart';
import 'package:listgen/globals/global_variables.dart';
import 'package:listgen/globals/list_controller.dart';

PreferredSizeWidget ListAppBar({required MainListItemHive mainListItem,required ListController listController, required BuildContext context}) {
  return AppBar(
    iconTheme: Theme.of(context).iconTheme,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    leading: GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: arrowBackIcon,
    ),
    title: Text(setAppbarTitle(mainListItem),style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),),
    actions: [
      GestureDetector(
        onTap: () {
          listController.setSelectedMainListItem(mainListItem.id);
          showListItemCRUDPopup(context, popupType: PopupType.Update);
        },
        child: editIcon,
      ),
      GestureDetector(
        onTap: () {
          listController.clearInputFields();
          showListItemCRUDPopup(context, listType: ListType.Sub);
        },
        child: Container(padding: EdgeInsets.all(padding), child: addIcon),
      )
    ],
  );
}

String setAppbarTitle(MainListItemHive mainListItem){
  String title = mainListItem.name;
  if(mainListItem.checkedItems.length+mainListItem.uncheckedItems.length > 0) {
    title += " (${mainListItem.checkedItems.length+mainListItem.uncheckedItems.length}";
    if(mainListItem.checkedItems.length+mainListItem.uncheckedItems.length>1){
      title += " Items)";
    } else {
      title += " Item)";
    }
  }
  return title;
}

