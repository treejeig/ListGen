import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:listgen/globals/widgets/empty_list_widget.dart';
import 'package:listgen/globals/global_variables.dart';
import 'package:listgen/modules/list_detail/widgets/list_appbar.dart';
import 'package:listgen/modules/list_detail/widgets/list_note_view.dart';
import 'package:listgen/modules/list_detail/widgets/sub_list_items_list.dart';
import 'package:listgen/globals/list_controller.dart';
import 'package:listgen/globals/hive_boxes.dart';
import 'package:listgen/models/hive/main_list_item_hive.dart';

class ListDetailPage extends ConsumerStatefulWidget {
  const ListDetailPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ListDetailPage> createState() => _ListDetailPageState();
}

class _ListDetailPageState extends ConsumerState<ListDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<MainListItemHive>>(
      valueListenable: HiveBoxes.getLocalList().listenable(),
      builder: (context, box, _) {
        final listController = ref.read(listProvider);
        final mainListItem = HiveBoxes.getLocalList().get(listController.selectedMainListItemId)!;
        bool isEmptyItems = mainListItem.uncheckedItems.isEmpty && mainListItem.checkedItems.isEmpty;
        return SafeArea(
          child: Scaffold(
            //backgroundColor: appBackgroundColor,
            appBar: ListAppBar(mainListItem:mainListItem, listController: listController, context: context),
            body: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(padding / 2),
                  child: Column(
                    children: [
                      //#region note area
                      Visibility(
                        visible: mainListItem.note.isNotEmpty,
                        child: ListNoteView(note: mainListItem.note),
                      ),
                      //#endregion

                      Visibility(
                          visible: mainListItem.note.isNotEmpty,
                          child: Divider(thickness: 2)
                      ),

                      //#region checked items
                      Visibility(
                        visible: mainListItem.checkedItems.isNotEmpty,
                        child: SubListItemsList(items: mainListItem.checkedItems, listController: listController),
                      ),
                      //#endregion

                      Visibility(visible: (mainListItem.checkedItems.isNotEmpty && mainListItem.uncheckedItems.isNotEmpty), child: Divider(thickness: 2)),

                      //#region unchecked items
                      Visibility(
                        visible: mainListItem.uncheckedItems.isNotEmpty,
                        child: SubListItemsList(subListType: SubListType.Unchecked,items: mainListItem.uncheckedItems, listController: listController)
                      ),
                      //#endregion

                      Visibility(visible: isEmptyItems, child: EmptyListWidget()),

                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
