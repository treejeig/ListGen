// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_list_item_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainListItemHiveAdapter extends TypeAdapter<MainListItemHive> {
  @override
  final int typeId = 1;

  @override
  MainListItemHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainListItemHive()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..note = fields[2] as String
      ..checkedItems = (fields[3] as List).cast<SubListItemHive>()
      ..uncheckedItems = (fields[4] as List).cast<SubListItemHive>();
  }

  @override
  void write(BinaryWriter writer, MainListItemHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.checkedItems)
      ..writeByte(4)
      ..write(obj.uncheckedItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainListItemHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
