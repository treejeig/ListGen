import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listgen/globals/listgen_themes.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:listgen/globals/global_variables.dart';
import 'package:listgen/models/hive/main_list_item_hive.dart';
import 'package:listgen/models/hive/sub_list_item_hive.dart';
import 'package:listgen/modules/home/home_page_view.dart';

void main() async {
  setPathUrlStrategy();
  await Hive.initFlutter();
  Hive.registerAdapter<MainListItemHive>(MainListItemHiveAdapter());
  Hive.registerAdapter<SubListItemHive>(SubListItemHiveAdapter());
  localListHiveBox = await Hive.openBox<MainListItemHive>("localListHiveBox");
  runApp(ProviderScope(child: ListGen()));
}

class ListGen extends StatelessWidget {
  const ListGen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ListGen",
      themeMode: ThemeMode.system,
      theme: ListGenThemes.lightTheme,
      darkTheme: ListGenThemes.darkTheme,
      home: HomePage(),
    );
  }
}
