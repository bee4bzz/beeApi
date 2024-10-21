part of 'models.dart';

/// A single element item.
///
/// [Cheptel] is immutable.
@immutable
@JsonSerializable()
class Cheptel extends Equatable implements Element {
  /// Defines the first data item inside the fogo app.
  const Cheptel({
    required this.id,
    this.name,
  });

  /// Creates a [Cheptel] from a JSON object.
  factory Cheptel.fromJson(JsonMap json) => _$CheptelFromJson(json);

  /// Converts this [Cheptel] to a JSON object.
  @override
  JsonMap toJson() => _$CheptelToJson(this);

  /// The unique identifier for this [Cheptel].
  @override
  final String id;

  /// The name of this [Cheptel].
  final String? name;

  @override
  List<Object?> get props => [id, name];
}
