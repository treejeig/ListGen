import 'package:flutter/material.dart';
import 'package:listgen/globals/global_variables.dart';

class ListNoteView extends StatelessWidget {
  const ListNoteView({Key? key,required this.note}) : super(key: key);
  final String note;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(padding),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(vertical: padding / 4, horizontal: padding),
        backgroundColor: Theme.of(context).cardColor,
        collapsedBackgroundColor: Theme.of(context).cardColor,
        textColor: Theme.of(context).textTheme.bodyText1!.color,
        collapsedTextColor: Theme.of(context).textTheme.bodyText1!.color,
        iconColor: Theme.of(context).iconTheme.color,
        collapsedIconColor: Theme.of(context).iconTheme.color,
        title: Text("Note"),
        expandedAlignment: Alignment.topLeft,
        childrenPadding: EdgeInsets.symmetric(vertical: padding / 2, horizontal: padding),
        children: [
          Text(note)
        ],
      ),
    );
  }


}