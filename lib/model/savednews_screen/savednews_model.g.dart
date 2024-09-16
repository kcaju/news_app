// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savednews_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavednewsModelAdapter extends TypeAdapter<SavednewsModel> {
  @override
  final int typeId = 0;

  @override
  SavednewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavednewsModel(
      title: fields[0] as String,
      content: fields[1] as String?,
      image: fields[3] as String?,
      date: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavednewsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavednewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
