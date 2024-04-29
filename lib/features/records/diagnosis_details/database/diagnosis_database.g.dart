// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiagnosisAdapter extends TypeAdapter<Diagnosis> {
  @override
  final int typeId = 0;

  @override
  Diagnosis read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Diagnosis(
      mobileId: fields[0] as String,
      serverId: fields[1] as String?,
      fileName: fields[2] as String,
      filePath: fields[3] as String,
      uploadTime: fields[4] as int,
      mobileDiagnosis: fields[5] as String,
      serverDiagnosis: fields[6] as String?,
      manualDiagnosis: fields[7] as String?,
      isBookmarked: fields[8] as bool?,
      isUploaded: fields[9] as bool?,
      isServerDiagnosed: fields[10] as bool?,
      confidenceScore: (fields[11] as List).cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, Diagnosis obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.mobileId)
      ..writeByte(1)
      ..write(obj.serverId)
      ..writeByte(2)
      ..write(obj.fileName)
      ..writeByte(3)
      ..write(obj.filePath)
      ..writeByte(4)
      ..write(obj.uploadTime)
      ..writeByte(5)
      ..write(obj.mobileDiagnosis)
      ..writeByte(6)
      ..write(obj.serverDiagnosis)
      ..writeByte(7)
      ..write(obj.manualDiagnosis)
      ..writeByte(8)
      ..write(obj.isBookmarked)
      ..writeByte(9)
      ..write(obj.isUploaded)
      ..writeByte(10)
      ..write(obj.isServerDiagnosed)
      ..writeByte(11)
      ..write(obj.confidenceScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiagnosisAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
