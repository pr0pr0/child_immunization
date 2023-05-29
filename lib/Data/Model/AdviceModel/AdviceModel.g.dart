// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdviceModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdviceModelAdapter extends TypeAdapter<AdviceModel> {
  @override
  final int typeId = 0;

  @override
  AdviceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdviceModel(
      id: fields[0] as int,
      advice: fields[1] as String,
      desc: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdviceModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.advice)
      ..writeByte(2)
      ..write(obj.desc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdviceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
