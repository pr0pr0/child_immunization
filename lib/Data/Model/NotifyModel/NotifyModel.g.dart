// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotifyModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotifyModelAdapter extends TypeAdapter<NotifyModel> {
  @override
  final int typeId = 3;

  @override
  NotifyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotifyModel(
      id: fields[0] as int,
      notify: fields[1] as String,
      desc: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotifyModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.notify)
      ..writeByte(2)
      ..write(obj.desc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotifyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
