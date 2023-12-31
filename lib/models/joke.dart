import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

@HiveType(typeId: 42)
@JsonSerializable()
class Joke {
  Joke({required this.id, required this.value, this.url});

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String value;

  @HiveField(2)
  final String? url;

  Map<String, dynamic> toJson() => _$JokeToJson(this);
}

class JokeAdapter extends TypeAdapter<Joke> {
  @override
  final int typeId = 42;

  @override
  Joke read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Joke(
      id: fields[0] as String,
      value: fields[1] as String,
      url: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Joke obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JokeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joke _$JokeFromJson(Map<String, dynamic> json) => Joke(
      id: json['id'] as String,
      value: json['value'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$JokeToJson(Joke instance) => <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'url': instance.url,
    };
