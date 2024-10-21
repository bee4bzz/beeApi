import 'dart:async';

import 'package:element_repository/src/element_api.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/subjects.dart';

/// Handle the element items use cases.
class ElementRepository<T extends Element> {
  ///
  ElementRepository({
    required ElementApi<T> api,
    required Logger logger,
  })  : _api = api,
        _logger = logger;

  final _controller = BehaviorSubject<Map<String, T>>();
  final ElementApi<T> _api;
  final Logger _logger;

  /// Returns a stream.
  Stream<Map<String, T>> get state => _controller.stream;

  /// Returns the current elements.
  Map<String, T> get lastState => _controller.stream.value;

  /// fetch all the elements.
  Future<Map<String, T>> fetchAll() async {
    _logger.finest('trying to fetch elements');

    try {
      final currentElements = await _api.fetchAll();
      _pushState(
        currentElements,
      );
      return currentElements;
    } catch (e) {
      _logger.severe('failed to get elements: $e');
      rethrow;
    }
  }

  /// Saves the element or replace it already exists.
  Future<void> save({
    required final T element,
  }) async {
    try {
      final currentElements = await _api.save(element: element);
      _pushState(currentElements);
    } catch (e) {
      _logger.severe('failed to save element: $e');
      rethrow;
    }
  }

  /// Saves all elements or replace them already exists.
  Future<void> saveAll({
    required final Map<String, T> elements,
  }) async {
    try {
      final currentElements = await _api.saveAll(elements: elements);
      _pushState(currentElements);
    } catch (e) {
      _logger.severe('failed to save elements: $e');
      rethrow;
    }
  }

  /// Deletes an element by its id.
  Future<void> delete({
    required String id,
  }) async {
    try {
      final currentElements = await _api.delete(id: id);
      _pushState(currentElements);
    } catch (e) {
      _logger.severe('failed to delete element: $e');
      rethrow;
    }
  }

  void _pushState(Map<String, T> elements) {
    _controller.add(elements);
  }

  /// Close the repository.
  Future<void> dispose() async {
    await _controller.close();
  }
}
