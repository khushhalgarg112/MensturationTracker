// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeriodDataAdapter extends TypeAdapter<PeriodData> {
  @override
  final int typeId = 1;

  @override
  PeriodData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeriodData(
      fields[0] as DateTime,
      (fields[1] as List).cast<bool>(),
      fields[2] as String,
      fields[3] == null ? 0 : fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PeriodData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.periodDate)
      ..writeByte(1)
      ..write(obj.symptoms)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.flow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
