import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:listgen/globals/hive_boxes.dart';
import 'package:listgen/globals/global_variables.dart';
import 'package:listgen/globals/list_controller.dart';
import 'package:listgen/globals/global_functions.dart';
import 'package:listgen/globals/widgets/listgen_list_view.dart';
import 'package:listgen/models/hive/main_list_item_hive.dart';
import 'package:listgen/globals/widgets/empty_list_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  Widget build(BuildContext context) {
    final listController = ref.read(listProvider);
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Container(
              padding: EdgeInsets.all(padding/2),
              child: Column(
                children: [
                  Expanded(
                    child: ValueListenableBuilder<Box<MainListItemHive>>(
                      valueListenable: HiveBoxes.getLocalList().listenable(),
                      builder: (context,box,_){
                        final localList = box.values.toList().cast<MainListItemHive>();
                        return localList.isNotEmpty ? ListGenListView(items: localList,listController: listController) : EmptyListWidget();
                      },
                    )
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: (){
              listController.clearInputFields();
              showListItemCRUDPopup(context);
            },
            child: Icon(addIcon.icon,size: padding*3),
          ),
        ),
    );
  }
}
