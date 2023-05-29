// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'KidsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KidsModelAdapter extends TypeAdapter<KidsModel> {
  @override
  final int typeId = 2;

  @override
  KidsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KidsModel(
      id: fields[0] as int,
      name: fields[1] as String,
      pirth_date: fields[2] as String,
      pirth_place: fields[3] as String,
      blood: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, KidsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.pirth_date)
      ..writeByte(3)
      ..write(obj.pirth_place)
      ..writeByte(4)
      ..write(obj.blood);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KidsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
