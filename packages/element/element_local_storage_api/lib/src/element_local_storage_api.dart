import 'dart:async';
import 'dart:convert';
import 'package:element_repository/element_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stores elements locally.
class LocalElementApi<T extends Element> extends ElementApi<T> {
  /// [LocalElementApi] store the devices on the phone.
  LocalElementApi({
    required SharedPreferencesAsync plugin,
    required String key,
    required T Function(Map<String, dynamic> json) fromJson,
  })  : _plugin = plugin,
        _key = key,
        _fromJson = fromJson;

  final SharedPreferencesAsync _plugin;
  final String _key;
  final T Function(Map<String, dynamic> json) _fromJson;

  Future<String?> _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  /// Get elements from storage
  @override
  Future<Map<String, T>> fetchAll() async {
    String? elementsString;
    try {
      elementsString = await _getValue(_key);
      if (elementsString == null) {
        return {};
      }
      return Map<String, Map<dynamic, dynamic>>.from(
        json.decode(elementsString) as Map<String, dynamic>,
      ).map(
        (key, value) =>
            MapEntry(key, _fromJson(Map<String, dynamic>.from(value))),
      );
    } catch (e) {
      if (e.runtimeType.toString() == 'LateError') {
        throw const ElementException(
          code: ElementFailureCode.elementNotFound,
        );
      }
      return {};
    }
  }

  @override
  Future<Map<String, T>> save({
    required final T element,
  }) async {
    final elements = await fetchAll();
    elements[element.id] = element;
    await _setValue(_key, json.encode(elements));
    return elements;
  }

  @override
  Future<Map<String, T>> delete({
    required String id,
  }) async {
    final elements = await fetchAll();
    elements.remove(id);
    await _setValue(_key, json.encode(elements));
    return elements;
  }

  @override
  Future<Map<String, T>> saveAll({required Map<String, T> elements}) async {
    await _setValue(
      _key,
      json.encode(elements),
    );
    return elements;
  }

  @override
  Future<void> close() async {}
}
