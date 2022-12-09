import 'package:flutter/material.dart';
import 'package:listgen/globals/list_controller.dart';
import 'package:listgen/globals/global_functions.dart';
import 'package:listgen/globals/global_variables.dart';
import 'package:listgen/modules/list_detail/list_detail_view.dart';
import 'package:listgen/models/hive/main_list_item_hive.dart';

class MainListItem extends StatelessWidget {
  const MainListItem({Key? key,required this.listController, required this.mainListItem}) : super(key: key);
  final ListController listController;
  final MainListItemHive mainListItem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setAndGoMainListItemDetail(context);
      },
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(padding),
            color: Theme.of(context).cardColor,
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(mainListItem.name),
                ),
                Container(
                  width: padding/2,
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          setSelectedMainListItem();
                          showListItemCRUDPopup(context,popupType:PopupType.Update);
                        },
                        child: Container(padding:EdgeInsets.only(right: padding/2),child: editIcon)),
                    GestureDetector(
                        onTap: (){
                          setSelectedMainListItem();
                          showListItemCRUDPopup(context,popupType:PopupType.Delete);
                        },
                        child: deleteIcon),
                  ],
                )
              ],
            ),
            Divider(thickness: 2),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(padding),
                          color: customGreen
                        ),
                        padding: EdgeInsets.symmetric(vertical: padding/2,horizontal: padding),
                          child: Text("Checked: ${mainListItem.checkedItems.length}")),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(padding),
                              color: customRed
                          ),
                          padding: EdgeInsets.symmetric(vertical: padding/2,horizontal: padding),
                          child: Text("Unchecked: ${mainListItem.uncheckedItems.length}")),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void setSelectedMainListItem(){
    listController.setSelectedMainListItem(mainListItem.id);
  }

  void setAndGoMainListItemDetail(BuildContext context) {
    setSelectedMainListItem();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListDetailPage()),
    );
  }
}