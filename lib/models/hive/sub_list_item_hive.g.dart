// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_list_item_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubListItemHiveAdapter extends TypeAdapter<SubListItemHive> {
  @override
  final int typeId = 2;

  @override
  SubListItemHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubListItemHive()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..isChecked = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, SubListItemHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubListItemHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
