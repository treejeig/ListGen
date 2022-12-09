import 'package:flutter/material.dart';
import 'package:listgen/globals/global_functions.dart';
import 'package:listgen/globals/global_variables.dart';
import 'package:listgen/globals/list_controller.dart';
import 'package:listgen/models/hive/sub_list_item_hive.dart';

class SubListItem extends StatelessWidget {
  const SubListItem({Key? key,required this.listController, required this.subListItem}) : super(key: key);
  final ListController listController;
  final SubListItemHive subListItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setSelectedSubListItem();
        setSubListItemCheck();
      },
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(padding),
            color: Theme.of(context).cardColor
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(subListItem.name),
                ),
                Container(
                  width: padding/2,
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          setSelectedSubListItem();
                          showListItemCRUDPopup(context,popupType: PopupType.Update,listType: ListType.Sub);
                        },
                        child: Container(padding:EdgeInsets.only(right: padding/2),child: editIcon)),
                    GestureDetector(
                        onTap: (){
                          setSelectedSubListItem();
                          showListItemCRUDPopup(context,listType:ListType.Sub,popupType:PopupType.Delete);
                        },
                        child: deleteIcon),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void setSelectedSubListItem(){
    listController.setSelectedSubListItem(subListItem.id);
  }

  void setSubListItemCheck(){
    listController.setSubListItemCheck();
  }

}