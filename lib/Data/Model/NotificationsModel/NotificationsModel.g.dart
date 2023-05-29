// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationsModelAdapter extends TypeAdapter<NotificationsModel> {
  @override
  final int typeId = 5;

  @override
  NotificationsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationsModel(
      id: fields[0] as int,
      name: fields[1] as String,
      message: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
