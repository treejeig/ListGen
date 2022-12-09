import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

double padding = 16.0;
late Box localListHiveBox;
Color customGreen = Color(0xFF8AD879);
Color customRed = Color(0xFFF3533A);
Icon arrowBackIcon = Icon(Icons.arrow_back_ios);
Icon editIcon = Icon(Icons.edit);
Icon addIcon = Icon(Icons.add_circle);
Icon deleteIcon = Icon(Icons.delete_forever);
Icon closeIcon = Icon(Icons.close);
double sizeMax = 500.0;
double sizeMin = 250.0;


enum PopupType{
  Add,Update,Delete
}

enum ListType{
  Main,Sub
}

enum ButtonType{
  Ok,Cancel
}

enum SubListType{
  Checked,Unchecked
}
