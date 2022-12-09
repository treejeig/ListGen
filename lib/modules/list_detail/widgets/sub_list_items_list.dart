import 'package:flutter/material.dart';
import 'package:listgen/globals/global_functions.dart';
import 'package:listgen/globals/global_variables.dart';
import 'package:listgen/globals/list_controller.dart';
import 'package:listgen/globals/widgets/listgen_list_view.dart';
import 'package:listgen/models/hive/sub_list_item_hive.dart';

class SubListItemsList extends StatelessWidget {
  const SubListItemsList({Key? key,this.subListType=SubListType.Checked,required this.items,required this.listController}) : super(key: key);
  final SubListType subListType;
  final List<SubListItemHive> items;
  final ListController listController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          children: [
            Container(
              height: padding*3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(padding),
                  color: subListType == SubListType.Checked ? customGreen.withOpacity(0.75) : customRed.withOpacity(0.75)
              ),
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: padding / 2),
              child: Stack(
                alignment: Alignment.centerRight,
                  children: [
                    Center(child: Text(setListTitle())),
                    Visibility(
                      visible: items.isNotEmpty,
                      child: GestureDetector(
                        onTap: (){
                          showListItemCRUDPopup(context,popupType: PopupType.Delete,listType: ListType.Sub,subListType:subListType);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:padding),
                            child: deleteIcon),
                      ),
                    )
                  ]),
            ),
            //#region list detail -> list item
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: padding / 4),
                child: Column(
                  children: [
                    items.isNotEmpty ?
                      Expanded(child: ListGenListView(listType: ListType.Sub,items: items,listController: listController),)
                        : Container(child: Center(child: Text(setListEmptyText())))
                  ],
                ),
              ),
            )
            //#endregion
          ],
        ));
  }

  String setListTitle(){
    return subListType == SubListType.Checked ? "Checked (${items.length})" : "Unchecked (${items.length})";
  }

  String setListEmptyText(){
    return subListType == SubListType.Checked ? "You did not complete any of your items" : "You already complete all of your items";
  }
}