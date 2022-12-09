import 'package:flutter/material.dart';
import 'package:listgen/globals/global_variables.dart';

class PopUpBottomButton extends StatelessWidget {
  const PopUpBottomButton({Key? key,required this.onClick,this.buttonType=ButtonType.Ok}) : super(key: key);
  final ButtonType buttonType;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
          onTap : (){
            onClick();
          },
          child: Container(
              padding: EdgeInsets.symmetric(vertical: padding/1.5,horizontal: padding),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: buttonType==ButtonType.Ok ? Radius.zero : Radius.circular(padding),
                      bottomRight: buttonType==ButtonType.Ok ? Radius.circular(padding) : Radius.zero
                  ),
                  color: buttonType==ButtonType.Ok ? customGreen : customRed
              ), child: Icon(buttonType==ButtonType.Ok ? Icons.check : Icons.close,color: Colors.white,)),
        ));
  }
}
