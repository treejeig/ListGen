import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listgen/globals/global_variables.dart';
import 'package:listgen/globals/list_controller.dart';
import 'package:listgen/modules/home/widgets/main_list_item_view.dart';
import 'package:listgen/modules/list_detail/widgets/sub_list_item_view.dart';

class ListGenListView extends StatelessWidget {
  const ListGenListView({Key? key,this.listType = ListType.Main, required this.items,required this.listController}) : super(key: key);
  final ListType listType;
  final List<dynamic> items;
  final ListController listController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },),
        child: ListView.separated(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          controller: ScrollController(),
          itemCount: items.length,
          separatorBuilder: (BuildContext context, int index){
            return Container(height: padding/2);
          },
          itemBuilder: (BuildContext context, int index) {
            return listType == ListType.Main ? MainListItem(listController:listController,mainListItem:items[index]) : SubListItem(listController: listController, subListItem: items[index]);
          },
        ),
      ),
    );
  }
}