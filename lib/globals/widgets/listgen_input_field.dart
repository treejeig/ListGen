import 'package:flutter/material.dart';
import 'package:listgen/globals/global_variables.dart';

class ListGenInputField extends StatelessWidget {
  const ListGenInputField({Key? key,required this.hintText,required this.controller,required this.focusNode,this.maxLines=1,this.onSubmitted}) : super(key: key);
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final int maxLines;
  final Function? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: padding/4),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).textTheme.bodyText1!.color!, width: padding/8),
            borderRadius: BorderRadius.circular(padding*2)
        ),
        padding: EdgeInsets.symmetric(horizontal: padding/2),
        child: TextField(
          cursorColor: Theme.of(context).textTheme.bodyText1!.color!,
          focusNode: focusNode,
          autofocus: true,
          maxLines: maxLines,
          onChanged: (val) {},
          onSubmitted: (val){
            if(onSubmitted!=null){
              onSubmitted!();
            }
          },
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(padding),
              hintText: hintText,
              hintMaxLines: maxLines,
              hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
