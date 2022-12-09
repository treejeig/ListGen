import 'package:flutter/material.dart';
import 'package:listgen/globals/widgets/list_item_crud_popup.dart';
import 'package:listgen/globals/global_variables.dart';

void showListItemCRUDPopup(BuildContext context,{PopupType popupType=PopupType.Add,ListType listType=ListType.Main,SubListType? subListType}) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return Container(
          constraints: BoxConstraints(
            maxWidth: sizeMax,
            maxHeight: sizeMax,
            minWidth: sizeMin,
            minHeight: sizeMin
          ),
            child: ListItemCRUDPopup(popupType: popupType,listType: listType,subListType: subListType));
      });
}