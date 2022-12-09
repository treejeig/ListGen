import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listgen/globals/list_controller.dart';
import 'package:listgen/globals/widgets/listgen_input_field.dart';
import 'package:listgen/globals/widgets/popup_bottom_button.dart';
import 'package:listgen/globals/global_variables.dart';

class ListItemCRUDPopup extends ConsumerStatefulWidget {
  ListItemCRUDPopup({Key? key,required this.popupType,required this.listType,this.subListType}) : super(key: key);
  final PopupType popupType;
  final ListType listType;
  final SubListType? subListType;

  @override
  ConsumerState<ListItemCRUDPopup> createState() => _ListItemCRUDPopupState();
}

class _ListItemCRUDPopupState extends ConsumerState<ListItemCRUDPopup> {
  @override
  Widget build(BuildContext context) {
    final listController = ref.watch(listProvider);
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(padding))
      ),
      titlePadding: EdgeInsets.zero,
      title: Container(
          constraints: BoxConstraints(
              maxWidth: sizeMax,
              minWidth: sizeMin,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(padding),topLeft: Radius.circular(padding)),
            color: Theme.of(context).cardColor,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(padding),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(setPopUpTitle()),
                ],
              ),
              Positioned(
                  right: 0,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(closeIcon.icon,color:Theme.of(context).textTheme.bodyText1!.color)
                  )
              )
            ],
          )
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.75),
      contentPadding: EdgeInsets.zero,
      content: Container(
        constraints: BoxConstraints(
            maxWidth: sizeMax,
            minWidth: sizeMin,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(padding),bottomRight: Radius.circular(padding)),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  Visibility(
                    visible: widget.popupType!=PopupType.Delete,
                    child: ListGenInputField(
                      hintText: widget.listType==ListType.Main ? "List Name" : "List Item Name",
                      controller: widget.listType==ListType.Main ? listController.mainListItemNameController : listController.subListItemNameController,
                      focusNode: widget.listType==ListType.Main ? listController.mainListItemNameFocusNode : listController.subListItemNameFocusNode,
                      onSubmitted: (){
                        doOnClick(listController, context);
                      },
                    ),
                  ),
                  Visibility(
                      visible:(widget.listType==ListType.Main && widget.popupType!=PopupType.Delete),
                      child: ListGenInputField(
                          hintText: "List Note",
                          controller: listController.mainListItemNoteController,
                          focusNode: listController.mainListItemNoteFocusNode,
                          maxLines: 3,
                          onSubmitted: (){
                            doOnClick(listController, context);
                          }
                      ),
                  ),
                  Visibility(
                    visible: widget.popupType==PopupType.Delete,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(setDeleteText(listController))
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
      actionsPadding: EdgeInsets.zero,
      actions: [
        Row(
          children: [
            PopUpBottomButton(
                buttonType: ButtonType.Cancel,
                onClick: (){
                  Navigator.pop(context);
                }
            ),
            PopUpBottomButton(
                onClick: (){
                  doOnClick(listController,context);
                }
            ),
          ],
        )
      ],
    );
  }

  doOnClick(ListController listController,BuildContext context){
    if(widget.listType==ListType.Main){
      if(widget.popupType==PopupType.Add){
        listController.addMainListItem();
      } else if(widget.popupType==PopupType.Update){
        listController.updateMainListItem();
      } else {
        listController.deleteMainListItem();
      }
      Navigator.pop(context);
    } else {
      if(widget.popupType==PopupType.Add){
        listController.addSubListItem();
      } else if(widget.popupType==PopupType.Update){
        listController.updateSubListItem();
        Navigator.pop(context);
      } else {
        if(widget.subListType!=null){
          listController.deleteSubListItems(widget.subListType!);
        } else {
          listController.deleteSubListItem();
        }
        Navigator.pop(context);
      }
    }
  }

  String setPopUpTitle() {
    String title = "";
    title = widget.popupType == PopupType.Add ? "Add " : widget.popupType == PopupType.Update ? "Update " : "Delete ";
    title += setListTypeForTitle();
    return title;
  }

  String setListTypeForTitle(){
    return widget.listType == ListType.Main ? "List" : widget.subListType==null ? "List Item" : "List Items";
  }

  String setDeleteText(ListController listController){
    String text = "Delete ";
    if(widget.subListType!=null){
      text+= "all \"${widget.subListType!.name}\" items of List ${listController.mainListItemNameController.text} ?";
    } else {
      text+= widget.listType == ListType.Main ? "List \"${listController.mainListItemNameController.text}\" ?" : "List Item \"${listController.subListItemNameController.text}\" ?";
    }
    return text;
  }
}
