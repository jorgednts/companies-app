// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enterprise_type_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnterpriseTypeCMAdapter extends TypeAdapter<EnterpriseTypeCM> {
  @override
  final int typeId = 1;

  @override
  EnterpriseTypeCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnterpriseTypeCM(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EnterpriseTypeCM obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.enterpriseTypeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnterpriseTypeCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
