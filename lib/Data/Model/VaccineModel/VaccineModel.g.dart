// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VaccineModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VaccineModelAdapter extends TypeAdapter<VaccineModel> {
  @override
  final int typeId = 6;

  @override
  VaccineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VaccineModel(
      id: fields[0] as int,
      name: fields[1] as String,
      daysToTake: fields[2] as int,
      desc: fields[3] as String,
      dose: fields[4] as String,
      isTaken: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, VaccineModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.daysToTake)
      ..writeByte(3)
      ..write(obj.desc)
      ..writeByte(4)
      ..write(obj.dose)
      ..writeByte(5)
      ..write(obj.isTaken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
