// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HospitalModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HospitalModelAdapter extends TypeAdapter<HospitalModel> {
  @override
  final int typeId = 4;

  @override
  HospitalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HospitalModel(
      id: fields[0] as int,
      name: fields[1] as String,
      typeId: fields[2] as int,
      latitude: fields[3] as String,
      longtitude: fields[4] as String,
      cityId: fields[5] as int,
      hospitalType: fields[6] as String,
      city: fields[7] as String,
      address: fields[8] as String,
      phoneNumber: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HospitalModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.typeId)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longtitude)
      ..writeByte(5)
      ..write(obj.cityId)
      ..writeByte(6)
      ..write(obj.hospitalType)
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.address)
      ..writeByte(9)
      ..write(obj.phoneNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HospitalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
